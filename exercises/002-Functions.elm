module Functions exposing (main)

import Expect
import Test exposing (..)
import Test.Runner.Html


{--

1. Write a function called `isLeapYear` that determines if a year is a leap year.

Source: http://exercism.io/exercises/elm/leap/readme

Description:
============

The leap year in the Gregorian calendar occurs:
  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400

Example usage:
==============

isLeapYear 1996
True

isLeapYear 1998
False

Hints:
======

* You may want to write a helper function that uses the built-in `rem` function
  * http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#rem
* Elm has the familiar boolean operators && and ||.
* Elm has a `not` function instead of a ! operator.
* Remember parentheses to group expressions.

--}


isLeapYear year =
    False



{--

2. Write a function called `respond` that responds to a message in different ways.
   Imagine that the `respond` function is a lazy teenager answering you.

Source: http://exercism.io/exercises/elm/bob/readme

Description:
============

Use these rules for responding to a message.
  * If you ask a question, return "Sure."
  * If you shout with all caps, return "Calm down!"
  * If you address the teenager with nothing (hint: an empty message), return "Fine. Be that way!"
  * For every other message, return "Whatever."

Example usage:
==============

respond "Do you like summer?"
"Sure."

respond "WHAT'S THE PROBLEM?"
"Calm down!"

respond ""
"Fine. Be that way!"

respond "Hello."
"Whatever."

Hints:
======

* The function takes a string and returns a string.
* You'll need some helper functions from the String module:
  * http://package.elm-lang.org/packages/elm-lang/core/latest/String
* if-else expressions can include `else if` branches
    if this then
        ...
    else if that then
        ...
    else
        ...
* Be careful about the order of your `if` predicates.

--}


respond message =
    ""



{--

3. Write a function called `mathOperations` that takes a number and performs a few operations.

Description:
============
  * Your function must double the number, square it, and then add 1 to it.
  * The catch is that you have to use the |> operator to perform the operations.
  * You must use the helper functions `add` and `multiply`.
  * You will probably want to write a helper function for squaring a number too.

Example usage:
==============

mathOperations 3
37

mathOperations 4
65

Hint:
=====

Remember how curried functions work.

--}


mathOperations x =
    -1



-- Please don't modify `add` and `multiply`


add x y =
    x + y


multiply x y =
    x * y



{--==========================================================================
                         DO NOT MODIFY BELOW THIS LINE
   ==========================================================================--}


testIsLeapYear =
    describe "isLeapYear"
        [ test "leap year" <|
            \() ->
                isLeapYear 1996
                    |> Expect.true "Expected 1996 to be a leap year."
        , test "non-leap year" <|
            \() ->
                isLeapYear 1997
                    |> Expect.false "Expected 1997 not to be a leap year."
        , test "non-leap even year" <|
            \() ->
                isLeapYear 1998
                    |> Expect.false "Expected 1998 not to be a leap year."
        , test "century" <|
            \() ->
                isLeapYear 1900
                    |> Expect.false "Expected 1900 not to be a leap year."
        , test "second century" <|
            \() ->
                isLeapYear 1800
                    |> Expect.false "Expected 1800 not to be a leap year."
        , test "fourth century" <|
            \() ->
                isLeapYear 2400
                    |> Expect.true "Expected 2400 to be a leap year."
        , test "y2k" <|
            \() ->
                isLeapYear 2000
                    |> Expect.true "Expected 2000 to be a leap year."
        ]


testRespond =
    describe "respond"
        [ test "question" <|
            \() ->
                respond "Do you like questions?"
                    |> Expect.equal "Sure."
        , test "all caps shouting" <|
            \() ->
                respond "YOU ARE ANNOYING."
                    |> Expect.equal "Calm down!"
        , test "all caps question" <|
            \() ->
                respond "WHAT'S THE PROBLEM WITH YOU?"
                    |> Expect.equal "Calm down!"
        , test "no message" <|
            \() ->
                respond ""
                    |> Expect.equal "Fine. Be that way!"
        , test "no message spaced" <|
            \() ->
                respond "      "
                    |> Expect.equal "Fine. Be that way!"
        , test "no message with other types of whitespace" <|
            \() ->
                respond "\t  \n  \t  \n  "
                    |> Expect.equal "Fine. Be that way!"
        , test "regular messages" <|
            \() ->
                respond "Yo."
                    |> Expect.equal "Whatever."
        ]


testMathOperations =
    describe "mathOperations"
        [ test "101" <|
            \() ->
                mathOperations 5
                    |> Expect.equal 101
        ]


main =
    [ testIsLeapYear
    , testRespond
    , testMathOperations
    ]
        |> concat
        |> Test.Runner.Html.run
