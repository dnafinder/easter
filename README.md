[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=dnafinder/easter)

✝️ easter.m — MATLAB Easter Date Calculator (Gauss Algorithm, datetime version)

easter.m is a MATLAB function that computes the date of Easter Sunday using the classical Gauss algorithm, including all necessary corrections for leap years, the Metonic cycle, and differences between Julian and Gregorian calendars.
The function accepts scalar or vector input and returns the results as MATLAB datetime objects (no deprecated datenum or datestr).

✨ Features

📅 Computes Easter dates for any year > 33

📈 Supports scalar and vector input

🧠 Implements the full Gauss algorithm with all corrections

📘 Includes complete help section and full English in-code explanations

🕒 Modern MATLAB output using datetime, no deprecated functions

🔊 Optional display mode (verbose on/off)

📦 Repository

GitHub: https://github.com/dnafinder/easter

🛠 Requirements

Compatible with all modern MATLAB versions.
Uses datetime, year, inputParser, and basic arithmetic.

🚀 Usage

Default usage (current year, with display):
easter

Specific year (no display):
ED = easter(2007, 0)

Vector of years (with display):
ED = easter(2000:2010, 1)

The output ED is a datetime array, for example:
01-Apr-2007
04-Apr-2010
27-Mar-2016

You may format it as needed using standard datetime formatting:
ED.Format = 'dd-MMM-yyyy'

🧠 Function Summary

easter(year, verbose)

Input:
• year — integer scalar or row vector, > 33 (default = current year)
• verbose — 0/1 or logical flag to enable or suppress display (default = 1)

Output:
• ED — array of datetime objects representing Easter Sunday

📚 Algorithm Reference

This implementation follows the original Gauss Easter algorithm, extended with:

• Metonic cycle adjustments
• Julian vs Gregorian corrections
• Leap-year corrections
• Special-case adjustments for rare edge cases

Full explanation available at:
http://www.henk-reints.nl/easter/index.htm?frame=easteralg2.htm

📚 Citation

If you use this function for teaching, research, or publications, please cite:

Cardillo G. (2007). easter.m – An Easter Day calculator based on the Gauss algorithm.
GitHub: https://github.com/dnafinder/easter

🔑 License

Please refer to the LICENSE file in this repository for licensing details.

👤 Author

Giuseppe Cardillo
Email: giuseppe.cardillo.75@gmail.com
