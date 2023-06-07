module Types exposing (..)


type alias Model = { target:List Int
                    ,test:List Int
                    ,history:List (List Int)
                    }

type Msg = Add Int
            | Test