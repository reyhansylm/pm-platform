package src

import (
    "context"
    "database/sql"
    "encoding/json"
    "github.com/heroiclabs/nakama-common/runtime"
)


type Player struct {
    UserID   string `json:"userId"`    
    Username string `json:"username"`  
}

func CustomRpcc(ctx context.Context, logger runtime.Logger, db *sql.DB, nk runtime.NakamaModule, payload string) (string, error) {
 
    var player Player

    err := json.Unmarshal([]byte(payload), &player)

    if err != nil {
        return "", err
    }

    sqlStatement := "INSERT INTO users (id, username) VALUES ($1, $2)"
 
    _, err = db.Query(sqlStatement, player.UserID, player.Username) 
    if err != nil {
        return "", err
    }

    return "Veritabanina başariyla eklendi", nil
}


func CustomRpcTest(ctx context.Context, logger runtime.Logger, db *sql.DB, nk runtime.NakamaModule, payload string) (string, error) {
 
    var player Player

    err := json.Unmarshal([]byte(payload), &player)

    if err != nil {
        return "", err
    }

    sqlStatement := "INSERT INTO users (id, username) VALUES ($1, $2)"
 
    _, err = db.Query(sqlStatement, player.UserID, player.Username) 
    if err != nil {
        return "", err
    }

    return "Veritabanina başariyla eklendi", nil
}
