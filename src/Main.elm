module Main exposing (..)

import Color
import Html
import Element exposing (..)
import Style exposing (..)
import Style.Color


---- MODEL ----


type alias Model =
    { log : Log }


initialLog : Log
initialLog =
    [ { text = "cat nonexistantfile"
      , foregroundLogColor = White
      , backgroundLogColor = Black
      , attributes = []
      }
    , { text = "cat: nonexistantfile: No such file or directory"
      , foregroundLogColor = White
      , backgroundLogColor = Black
      , attributes = []
      }
    ]


init : ( Model, Cmd Msg )
init =
    ( { log = initialLog }, Cmd.none )



---- TYPES ----``


type alias Log =
    List LogLine


type alias LogLine =
    { text : String
    , foregroundLogColor : LogColor
    , backgroundLogColor : LogColor
    , attributes : List Attribute
    }


type LogColor
    = White
    | Black


type Attribute
    = Bright


type Styles
    = None
    | LogContainerStyle
    | LogLineStyle



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html.Html msg
view { log } =
    Element.layout stylesheet <|
        column None [] (renderLog log)


renderLog : Log -> List (Element Styles variation msg)
renderLog =
    List.map renderLogLine


renderLogLine : LogLine -> Element Styles variation msg
renderLogLine logLine =
    row LogLineStyle [] [ text logLine.text ]



---- STYLES ----


stylesheet : StyleSheet Styles variation
stylesheet =
    Style.styleSheet
        [ style LogContainerStyle []
        , style LogLineStyle
            [ Style.Color.background Color.black
            , Style.Color.text Color.white
            ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
