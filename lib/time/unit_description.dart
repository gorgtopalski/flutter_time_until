class UnitOfTimeDescription {
  static const _description = {
    // https://en.wikipedia.org/wiki/Year
    'years':
        'A year is the orbital period of a planetary body, for example, the Earth, moving in its orbit around the Sun.',
    // https://en.wikipedia.org/wiki/Month
    'months':
        'A month is a unit of time, used with calendars, which is approximately as long as a natural period related to the motion of the Moon',
    // https: //en.wikipedia.org/wiki/Week
    'weeks': 'A week is a time unit equal to seven days.',
    // https://en.wikipedia.org/wiki/Day
    'days':
        'A day is approximately the period of time during which the Earth completes one rotation around its axis.',
    // https://en.wikipedia.org/wiki/Hour
    'hours':
        'An hour is a unit of time conventionally reckoned as ​1⁄24 of a day and scientifically reckoned as 3,599–3,601 seconds, depending on conditions. There are 60 minutes in an hour, and 24 hours in a day',
    // https://en.wikipedia.org/wiki/Minute
    'minutes':
        'The minute is a unit of time usually equal to ​1⁄60 of an hour, or 60 seconds. ',
    // https://en.wikipedia.org/wiki/Second
    'seconds':
        'The second is the base unit of time in the International System of Units (SI), commonly understood and historically defined as ​1⁄86400 of a day – this factor derived from the division of the day first into 24 hours, then to 60 minutes and finally to 60 seconds each',
    // https://en.wikipedia.org/wiki/Moment_(time)
    'moments':
        'A moment (momentum) was a medieval unit of time. The movement of a shadow on a sundial covered 40 moments in a solar hour, a twelfth of the period between sunrise and sunset. The length of a solar hour depended on the length of the day, which, in turn, varied with the season. Although the length of a moment in modern seconds was therefore not fixed, on average, a moment corresponded to 90 seconds.',
    // https://en.wikipedia.org/wiki/Decade
    'decades': 'A decade is a period of 10 years.',
    // https://en.wikipedia.org/wiki/Century
    'centuries': 'A century is a period of 100 years.',
    // https://en.wikipedia.org/wiki/Millennium
    'millenia':
        'A millennium is a period of one thousand years, sometimes called a kiloyear.',
    // https://en.wikipedia.org/wiki/Traditional_Chinese_timekeeping#One-hundredth_of_a_day:_K%C3%A8
    'ke':
        'A unit of the traditional Chinese timekeeping system. One kè was usually defined as 1/100 of a day.',
    // https://en.wikipedia.org/wiki/Planck_time
    'plank time':
        'The amount of time light takes to travel one Planck length. Theoretically, this is the smallest time measurement that will ever be possible.',
    // https://en.wikipedia.org/wiki/Galactic_year
    'galactic year':
        'The amount of time it takes the Solar System to orbit the center of the Milky Way Galaxy one time.',
    // https://en.wikipedia.org/wiki/Jiffy_(time)
    'electronic jiffies':
        'Used to measure the time between alternating power cycles. Also a casual term for a short period of time. ',
    'physics jiffies':
        'The amount of time light takes to travel one fermi (about the size of a nucleon) in a vacuum.',
  };

  static String getDescription(String timeUnit) {
    return _description[timeUnit] ?? "";
  }
}
