function ED = easter(varargin)
%EASTER Compute the date of Easter Sunday using the Gauss algorithm
%   ED = EASTER(YEAR, VERBOSE) computes the date of Easter Sunday for the
%   given YEAR (or vector of years). The result is returned as MATLAB
%   datetime objects.
%
%   If no input is provided, the current year is used and the date is
%   displayed in the Command Window.
%
%   INPUT
%     YEAR    - Scalar or row vector of integer years > 33.
%               Default: current year.
%
%     VERBOSE - 1/0 or logical:
%               1 (true)  → display Easter date(s)
%               0 (false) → silent
%               Default: 1.
%
%   OUTPUT
%     ED      - Datetime array with Easter Sundays for each requested year.
%
%   The algorithm implemented here is the classical Gauss method, extended
%   with corrections for the Metonic cycle and Julian/Gregorian calendars.
%
%   For a detailed and very clear explanation of the algorithm:
%       http://www.henk-reints.nl/easter/index.htm?frame=easteralg2.htm
%
%   ------------------------------------------------------------------
%   Author and citation:
%   ------------------------------------------------------------------
%   Created by:  Giuseppe Cardillo
%   E-mail:      giuseppe.cardillo.75@gmail.com
%
%   To cite this file:
%   Cardillo G. (2007). easter.m – An Easter Day calculator based on
%   the Gauss algorithm.
%
%   GitHub repository:
%   https://github.com/dnafinder/easter
%   ------------------------------------------------------------------

% ----------------------- Input parsing ------------------------------
p = inputParser;

addOptional(p,'Y',year(datetime('now')), ...
    @(x) validateattributes(x, {'numeric'}, ...
    {'row','real','finite','integer','nonnan','positive','>',33}));

addOptional(p,'verbose',1, ...
    @(x) isscalar(x) && (islogical(x) || x==0 || x==1));

parse(p,varargin{:});

Y       = p.Results.Y;
verbose = logical(p.Results.verbose);

% ====================================================================
% ================   BEGIN EXTENDED ALGORITHM COMMENTS   =============
% ====================================================================
%
% Now we are going to take the Moon into account. It appears to be so that
% 235 lunations (i.e. moon months) are practically equal to 19 tropical
% years (a tropical year is the time between the beginning of spring one
% year and the next year). This means that every 19 years the moon phases
% will occur on the same dates in the year. This regularity was discovered
% by an ancient Greek called Meton and therefore this 19-year cycle is
% called the Metonic cycle (or moon cycle). Because this equality of 235
% lunations and 19 years is not really exact (the difference is
% approximately 2 hours), there is a small shift of about 1 day per 310
% years = ca. 8 days per 25 centuries. The value of M takes care of that
% shift (as far as I know Gauss did not include a calculation of M in his
% algorithm).
%
% P is simply the century index.
P = floor(Y ./ 100);

% Q takes care of the leap day difference between the Julian and the
% Gregorian calendar.
Q = floor((3 .* P + 3) ./ 4);

% R handles the shift of the Metonic cycle.
R = floor((8 .* P + 13) ./ 25);

% M is the long-term correction term for the Metonic cycle.
M = mod(15 + Q - R, 30);

% The value of N has to do with the difference in the number of leap days
% between the Gregorian and the Julian calendar. The Julian calendar has a
% leap day every 4 years, whilst the Gregorian calendar excludes the 100-fold
% years from being leap unless divisible by 400. Together, B and N handle
% the Gregorian leap days.
N = mod(4 + Q, 7);

% M and N values in the Julian Calendar (years <= 1582).
M(Y <= 1582) = 15;
N(Y <= 1582) = 6;

% A is the offset (0..18) of the given year within the corresponding
% Metonic cycle.
A = mod(Y, 19);

% C takes care of the weekday shift due to non-leap years.
C = mod(Y, 7);

% B counts leap days according to the Julian calendar.
B = mod(Y, 4);

% D handles the Metonic cycle and the long-term shift thereof, and gives the
% number of days (0..29) to be added to March 21 to get the Paschal Full Moon.
D = mod(19 .* A + M, 30);

% E handles the weekday computation so that the first Sunday after PFM + 1
% is found.
E = mod(2.*B + 4.*C + 6.*D + N, 7);

% F is the day offset starting from March 22. If F>31 → date rolls into April.
F  = 22 + D + E;
Em = 3 * ones(size(Y));  % 3 = March

% If F > 31, roll over to April.
I = find(F > 31);
if ~isempty(I)
    F(I)  = F(I) - 31;
    Em(I) = 4; % April

    % Final correction:
    % If F = 26 OR (F = 25 & E = 6 & A > 10), subtract 7 days.
    K = find(F(I) == 26 | (F(I) == 25 & E(I) == 6 & A(I) > 10));
    if ~isempty(K)
        F(I(K)) = F(I(K)) - 7;
    end
end

% ====================================================================
% ==================   END EXTENDED ALGORITHM COMMENTS   =============
% ====================================================================

% ----------------------- Output as DATETIME -------------------------
ED = datetime(Y, Em, F);

% ----------------------- Display (if verbose) -----------------------
if verbose
    disp(ED);
end

end
