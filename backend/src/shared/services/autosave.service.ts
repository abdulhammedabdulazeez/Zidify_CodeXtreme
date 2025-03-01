import { BadRequestException } from '@nestjs/common';
import { SaveGoal, SAVEGOALSFREQUENCY } from '@prisma/client';
import {
  addDays,
  addMonths,
  addWeeks,
  isBefore,
  setHours,
  setMinutes,
} from 'date-fns';
import { AutoSaveOptions } from 'src/common/types';

export interface FrequencyValidationParams {
  frequency: string;
  dayOfWeek?: number;
  dayOfMonth?: number;
  time?: string;
  startDate?: Date;
}

export class AutoSaveService {
  /**
   * Computes the next auto-save date based on the provided SaveGoal.
   * @param saveGoal - The SaveGoal to compute the next auto-save date for.
   * @returns {Date} - The next auto-save date.
   *
   * @example
   * const saveGoal = await saveGoalService.findOne('123');
   * const nextAutoSave = autoSaveService.computeNextAutoSaveAfterElapsed(saveGoal);
   * console.log(nextAutoSave); // 2022-01-01T00:00:00.000Z
   */
  public computeNextAutoSaveAfterElapsed(saveGoal: SaveGoal): Date {
    const now = new Date();
    const endDate = saveGoal.goalEndDate
      ? new Date(saveGoal.goalEndDate)
      : null;
    let nextSave: Date;

    // Parse autoSaveTime or default to current time
    let [hours, minutes] = saveGoal.autoSaveTime
      ? saveGoal.autoSaveTime.split(':').map(Number)
      : [now.getHours(), now.getMinutes()];

    switch (saveGoal.autoSaveFrequency) {
      case SAVEGOALSFREQUENCY.daily:
        nextSave = this.getNextDailyDate(now, hours, minutes);
        break;

      case SAVEGOALSFREQUENCY.weekly:
        nextSave = this.getNextWeeklyDate(
          now,
          saveGoal.autoSaveDayOfTheWeek || now.getDay(),
          hours,
          minutes,
        );
        break;

      case SAVEGOALSFREQUENCY.monthly:
        nextSave = this.getNextMonthlyDate(
          now,
          saveGoal.autoSaveDayOfTheMonth || now.getDate(),
          hours,
          minutes,
        );
        break;

      default:
        return null;
    }

    // TODO: SaveGoal autosave constraint should be when the target amount is reached
    // If endDate exists, ensure nextSave doesn't exceed it
    if (endDate && isBefore(endDate, nextSave)) {
      // Use the end date as the next auto-save date, but maintain the specified time
      const lastPossibleSave = new Date(endDate);
      lastPossibleSave.setHours(hours, minutes, 0, 0);

      // If the adjusted time on end date is still in the future, use that
      // Otherwise, use the original end date
      return isBefore(lastPossibleSave, endDate) ? lastPossibleSave : endDate;
    }

    return nextSave;
  }

  /**
   * Validates the funding source for non-manual auto-save frequencies.
   * @param dto - The CreateSaveGoalDto to compute the next auto-save date for.
   * @returns {Date} - The next auto-save date.
   * @throws {BadRequestException} - If the funding source is missing for non-manual frequencies.
   */
  public validateFundingSource(
    autoSaveFrequency: string,
    fundingSourceId: string,
    fundingSourceType: string,
  ) {
    if (autoSaveFrequency !== SAVEGOALSFREQUENCY.manual) {
      if (!fundingSourceId || !fundingSourceType) {
        throw new BadRequestException(
          'Fund source id and type are required for auto-save frequency',
        );
      }
    }
  }

  /**
   * Computes the next auto-save date based on the provided SaveGoal.
   * @param dto - The CreateSaveGoalDto to compute the next auto-save date for.
   * @returns {Date} - The next auto-save date.
   */
  public computeNextAutoSave(option: AutoSaveOptions): Date {
    const startDate = option.startDate
      ? new Date(option.startDate)
      : new Date();
    const endDate = option.endDate ? new Date(option.endDate) : null;
    let nextSave: Date;

    // Parse autoSaveTime or default to midnight
    let [hours, minutes] = option.autoSaveTime
      ? option.autoSaveTime.split(':').map(Number)
      : [0, 0];

    switch (option.autoSaveFrequency) {
      case SAVEGOALSFREQUENCY.daily:
        console.log('daily');
        nextSave = this.getNextDailyDate(startDate, hours, minutes);
        break;

      case SAVEGOALSFREQUENCY.weekly:
        console.log('weekly');
        console.log(option);
        nextSave = this.getNextWeeklyDate(
          startDate,
          option.autoSaveDayOfTheWeek || 1,
          hours,
          minutes,
        );
        break;

      case SAVEGOALSFREQUENCY.monthly:
        console.log('monthly');
        nextSave = this.getNextMonthlyDate(
          startDate,
          option.autoSaveDayOfTheMonth || 1,
          hours,
          minutes,
        );
        break;

      default:
        return null;
    }

    // If endDate exists, ensure nextSave doesn't exceed it
    if (endDate && isBefore(endDate, nextSave)) {
      // Use the end date as the next auto-save date, but maintain the specified time
      const lastPossibleSave = new Date(endDate);
      lastPossibleSave.setHours(hours, minutes, 0, 0);

      // If the adjusted time on end date is still in the future, use that
      // Otherwise, use the original end date
      return isBefore(lastPossibleSave, endDate) ? lastPossibleSave : endDate;
    }

    return nextSave;
  }

  private getNextDailyDate(
    startDate: Date,
    hours: number,
    minutes: number,
  ): Date {
    const now = new Date();
    let nextDate = new Date(startDate);

    // If start date is today, check if the time has passed
    if (nextDate.toDateString() === now.toDateString()) {
      const targetTime = new Date(now);
      targetTime.setHours(hours, minutes, 0, 0);

      if (now > targetTime) {
        // If time has passed, move to next day
        nextDate = addDays(nextDate, 1);
      }
    }

    return setHours(setMinutes(nextDate, minutes), hours);
  }

  private getNextWeeklyDate(
    startDate: Date,
    dayOfWeek: number,
    hours: number,
    minutes: number,
  ): Date {
    let nextDate = new Date(startDate);
    const currentDay = nextDate.getDay();

    if (currentDay > dayOfWeek) {
      nextDate = addWeeks(nextDate, 1);
    }
    const daysToAdd = (dayOfWeek + 7 - currentDay) % 7;
    nextDate = addDays(nextDate, daysToAdd);

    return setHours(setMinutes(nextDate, minutes), hours);
  }

  private getNextMonthlyDate(
    startDate: Date,
    dayOfMonth: number,
    hours: number,
    minutes: number,
  ): Date {
    let nextDate = new Date(startDate);
    nextDate.setDate(dayOfMonth);

    if (nextDate < startDate) {
      nextDate = addMonths(nextDate, 1);
    }

    return setHours(setMinutes(nextDate, minutes), hours);
  }

  /**
   * Validates the frequency-specific fields for auto-save.
   * @param frequency - The frequency of the auto-save.
   * @param dayOfWeek - The day of the week for weekly auto-save.
   * @param dayOfMonth - The day of the month for monthly auto-save.
   * @param time - The time of day for the auto-save.
   * @param startDate - The start date for the auto-save.
   * @throws {BadRequestException} - If any of the fields are invalid.
   */
  public validateFrequencyFields({
    frequency,
    dayOfWeek,
    dayOfMonth,
    time = '00:00',
    startDate = new Date(),
  }: FrequencyValidationParams): void {
    switch (frequency) {
      case 'daily':
        if (!time) {
          throw new BadRequestException('Time is required for daily frequency');
        }
        if (dayOfWeek || dayOfMonth) {
          throw new BadRequestException(
            'Day of week and day of month should not be set for daily frequency',
          );
        }
        AutoSaveService.validateTimeFormat(time);
        break;

      case 'weekly':
        if (dayOfMonth) {
          throw new BadRequestException(
            'Day of month should not be set for weekly frequency',
          );
        }
        if (typeof dayOfWeek !== 'number') {
          throw new BadRequestException(
            'Day of week is required for weekly frequency',
          );
        }
        AutoSaveService.validateDayOfWeek(dayOfWeek);
        break;

      case 'monthly':
        if (dayOfWeek) {
          throw new BadRequestException(
            'Day of week should not be set for monthly frequency',
          );
        }
        if (typeof dayOfMonth !== 'number') {
          throw new BadRequestException(
            'Day of month is required for monthly frequency',
          );
        }
        AutoSaveService.validateDayOfMonth(dayOfMonth, startDate);
        break;

      default:
        throw new BadRequestException('Invalid frequency');
    }
  }

  private static validateTimeFormat(time: string): void {
    if (!/^([01]?[0-9]|2[0-3]):[0-5][0-9]$/.test(time)) {
      throw new BadRequestException('Time must be in HH:mm format');
    }
  }

  private static validateDayOfWeek(day: number): void {
    if (day < 0 || day > 6) {
      throw new BadRequestException('Day of week must be between 0 and 6');
    }
  }

  private static validateDayOfMonth(day: number, startDate: Date): void {
    if (day < 1) {
      throw new BadRequestException('Day of month must be greater than 0');
    }

    startDate = new Date(startDate);

    // Get the last day of the month for the given start date
    const year = startDate.getFullYear();
    const month = startDate.getMonth(); // 0-11
    const lastDayOfMonth = new Date(year, month + 1, 0).getDate();

    // Special handling for February
    if (month === 1) {
      // February
      const maxDay = 28;
      if (day > maxDay) {
        throw new BadRequestException(`February only accepts days 1-${maxDay}`);
      }
    }
    // Handle months with 30 days
    else if ([3, 5, 8, 10].includes(month) && day > 30) {
      // April, June, September, November
      throw new BadRequestException('Selected month only has 30 days');
    }
    // Handle months with 31 days
    else if (day > 31) {
      throw new BadRequestException('Day of month cannot exceed 31');
    }
  }
}
