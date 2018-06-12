module JazzAlbums exposing (main)

import Html exposing (Html, div, h2, h3, i, img, input, label, li, text, ul)
import Html.Attributes exposing (class, classList, src, type_, value)
import Html.Events exposing (onClick, onInput)


---- CONSTANTS ----


baseUrl : String
baseUrl =
    "https://jazz-album-covers.surge.sh/images/"


type Rating
    = Unrated
    | Liked
    | Disliked


type alias Id =
    Int


type alias Album =
    { id : Id
    , title : String
    , coverUrl : String
    , artist : String
    , rating : Rating
    }


albums : List Album
albums =
    [ { id = 1
      , title = "Kind of Blue"
      , coverUrl = baseUrl ++ "miles-davis-kind-of-blue.jpg"
      , artist = "Miles Davis"
      , rating = Unrated
      }
    , { id = 2
      , title = "A Love Supreme"
      , coverUrl = baseUrl ++ "john-coltrane-a-love-supreme.jpg"
      , artist = "John Coltrane"
      , rating = Unrated
      }
    , { id = 3
      , title = "Out to Lunch"
      , coverUrl = baseUrl ++ "eric-dolphy-out-to-lunch.jpg"
      , artist = "Eric Dolphy"
      , rating = Unrated
      }
    , { id = 4
      , title = "Blue Train"
      , coverUrl = baseUrl ++ "john-coltrane-blue-train.jpg"
      , artist = "John Coltrane"
      , rating = Unrated
      }
    ]



---- MODEL ----


type alias Model =
    { albums : List Album
    , query : String
    }


initialModel : Model
initialModel =
    { albums = albums
    , query = ""
    }



---- UPDATE ----


updateRating : Rating -> Album -> Album
updateRating rating album =
    if album.rating == rating then
        { album | rating = Unrated }
    else
        { album | rating = rating }


like : Album -> Album
like =
    updateRating Liked


dislike : Album -> Album
dislike =
    updateRating Disliked


updateAlbum : (Album -> Album) -> Id -> List Album -> List Album
updateAlbum updater id albums =
    List.map
        (\album ->
            if album.id == id then
                updater album
            else
                album
        )
        albums


type Msg
    = Like Id
    | Dislike Id


update : Msg -> Model -> Model
update msg model =
    case msg of
        Like id ->
            { model | albums = updateAlbum like id model.albums }

        Dislike id ->
            { model | albums = updateAlbum dislike id model.albums }



---- VIEW ----


filterAlbums : Model -> List Album
filterAlbums model =
    model.albums


view : Model -> Html Msg
view model =
    div [ class "albums" ]
        [ viewAlbumFilters model
        , viewAlbumList model.albums
        ]


viewAlbumFilters : Model -> Html Msg
viewAlbumFilters model =
    div [ class "album-filters" ]
        [ div [ class "album-filter" ]
            [ div []
                [ label [] [ text "Search Albums:" ] ]
            , input
                [ type_ "text"
                , value model.query

                -- , onInput (\query -> { type_ = "SEARCH", id = -1, query = query })
                ]
                []
            ]
        ]


viewAlbumList : List Album -> Html Msg
viewAlbumList albums =
    ul [ class "album-list" ]
        (List.map viewAlbum albums)


viewAlbum : Album -> Html Msg
viewAlbum album =
    li []
        [ div [ class "album" ]
            [ img [ src album.coverUrl ] []
            , div [ class "album__rating" ]
                [ i
                    [ class "far fa-lg fa-thumbs-up"
                    , classList [ ( "fa-thumbs-up--selected", album.rating == Liked ) ]
                    , onClick (Like album.id)
                    ]
                    []
                , i
                    [ class "far fa-lg fa-thumbs-down"
                    , classList [ ( "fa-thumbs-down--selected", album.rating == Disliked ) ]
                    , onClick (Dislike album.id)
                    ]
                    []
                ]
            , h2 [ class "album__title" ]
                [ text album.title ]
            , h3 [ class "album__artist" ]
                [ text album.artist ]
            ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }
