module JazzAlbums exposing (main)

import Html exposing (div, h2, h3, img, text)
import Html.Attributes exposing (class, src)


---- CONSTANTS ----


baseUrl =
    "https://jazz-album-covers.surge.sh/images/"


unrated =
    0



---- MODEL ----


initialModel =
    { id = 1
    , title = "Kind of Blue"
    , coverUrl = baseUrl ++ "miles-davis-kind-of-blue.jpg"
    , artist = "Miles Davis"
    , rating = unrated
    }



---- VIEW ----


view model =
    div [ class "albums" ]
        [ viewAlbum model ]


viewAlbum album =
    div [ class "album" ]
        [ img [ src album.coverUrl ] []
        , h2 [ class "album__title" ]
            [ text album.title ]
        , h3 [ class "album__artist" ]
            [ text album.artist ]
        ]



---- PROGRAM ----


main =
    view initialModel
