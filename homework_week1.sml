(*
* Write a function is_older that takes two dates and evaluates to true or
* false. It evaluates to true if
* the first argument is a date that comes before the second argument. (If the
* two dates are the same,
* the result is false.)
*)
fun is_older(date1:int*int*int, date2: int*int*int)=
    if (#1 date1) < (#1 date2)
    then true
    else if (#1 date1) = (#1 date2) andalso (#2 date1) < (#2 date2)
    then true
    else if (#1 date1) = (#1 date2) andalso (#2 date1) = (#2 date2) andalso (#3 date1) < (#3 date2)
    then true
    else false
(*
* Write a function number_in_month that takes a list of dates and a month (i.e.,
* an int) and returns
* how many dates in the list are in the given month.
*)
fun number_in_month(dates: (int*int*int) list, month:int)=
    if dates = []
    then 0
    else if (#2 (hd dates)) = month
    then 1 + number_in_month( (tl dates), month)
    else number_in_month( (tl dates), month)
    (*
    * recursion: number_in_month( (tl dates), month)
    *)
(*
* Write a function number_in_months that takes a list of dates and a list of
months (i.e., an int list) and returns the number of dates in the list of dates that are in any of
the months in the list of months.

Assume the list of months has no number repeated. Hint: Use your answer to the previous problem.
*)
fun number_in_months (dates: (int*int*int) list, months: int list)=
    if months = []
    then 0
    else (number_in_month (dates, hd months)) + (number_in_months(dates, tl
    months))

(*
Write a function dates_in_month that takes a list of dates and a month (i.e., an
int) and returns a list holding the dates from the argument list of dates that are in the month.

The returned list should contain dates in the order they were originally given.
*)

fun dates_in_month(dates:(int*int*int) list, month:int)=
    if dates = []
    then []
    else if #2 (hd dates) = month
    then (hd dates)::dates_in_month(tl dates, month)
    else dates_in_month(tl dates, month)

    (*
    * dates_in_month( [(1983,11,6)], 11 
    * *)
(*
* Write a function dates_in_months that takes a list of dates and a list of
months (i.e., an int list)
and returns a list holding the dates from the argument list of dates
that are in any of the months in
the list of months. Assume the list of months has no number
repeated. Hint: Use your answer to the
previous problem and SML’s list-append operator (@).
*)
fun dates_in_months(dates: (int*int*int) list, months: int list)=
    if months = []
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

(*
* Write a function get_nth that takes a list of strings and an int n and returns
* the nth element of the list where the head of the list is 1st. Do not worry about the case where the
* list has too few elements:
*
* your function may apply hd or tl to the empty list in this case, which is
* okay.
* 
* get_nth(["hello","my name", "is", "cattie", "goodbye!"], 4)
*
* get_nth([...], 1)
*)
fun get_nth( strings:string list, n:int )=
    if n=1
    then hd strings
    else get_nth(tl strings, n-1)



fun date_to_string(date:(int*int*int))=
    let val months=["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in
        (get_nth(months, #2(date))) ^ " " ^ (Int.toString (#3 date)) ^ ", " ^
        (Int.toString (#1 date))
    end

(*
* Write a function number_before_reaching_sum that takes an int called sum,
* which you can assume
* is positive, and an int list, which you can assume contains all positive
* numbers, and returns an int.
* You should return an int n such that the first n elements (nth position!) of the list add to
* less than sum, but the first
* n + 1 elements of the list add to sum or more. Assume the entire list sums to
* more than the passed in
    * value; it is okay for an exception to occur if this is not the case
    *)

    (* example:
    * number_before_reaching_sum(10,[1,2,3,4,5,6,7]); ====> 3
    * number_before_reaching_sum(10,[7,6,5,4,3,2,1]); ====> 1  OHHHHHH
    * 
    * number_before_reaching_sum(10,[7,0,0,0,1,1,1]); ====> 6  OHHHHHH
    *
    * number_before_reaching_sum(2,[0,0,0,1,1]); ====> 4
    *
    *
    *)

fun number_before_reaching_sum(sum:int, xs: int list)=
    if (hd xs) >= sum
    then 0
(*    else if (hd xs) + (hd (tl xs)) >= sum
    then hd xs (* *) *)
    else 1 + number_before_reaching_sum( sum - (hd xs), tl xs)
(*
*Write a function what_month that takes a day of year (i.e., an int between 1
and 365) and returns what month that day is in (1 for January, 2 for February, etc.). Use a list
holding 12 integers and your answer to the previous problem.

what_month(80); -----> 3

    Jan: 31    Jul: 31
    Feb: 28    Aug: 31
    Mar: 31    Sep: 30
    Apr: 30    Oct: 31
    May: 31    Nov: 30
    Jun: 30    Dec: 31
returns MONTH as an integer *)

(**what_month(80); -----> 3 *)
fun what_month (day:int)=
    let val m = [31,28,31,30,31,30,31,31,30,31,30,31]
    in
        number_before_reaching_sum(day,m) + 1
    end

(*problem 10*)
fun month_range(day1:int, day2:int)=
    if day1 > day2
    then []
    else what_month(day1)::month_range(day1+1,day2)
