module Functions exposing (main)

import Html exposing (div, text)
import Html.Attributes exposing (class)


output =
    "Hello World"



{--==========================================================================
                         DO NOT MODIFY BELOW THIS LINE
   ==========================================================================--}


main =
    div [ class "demo" ]
        [ text (toString output) ]
