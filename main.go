package main

import (

    "partty-monsterzz/src"
    "context"
    "database/sql"
    "encoding/json"
    "github.com/heroiclabs/nakama-common/runtime"
)

func main(){
    
}

func InitModule(ctx context.Context, logger runtime.Logger, db *sql.DB, nk runtime.NakamaModule, initializer runtime.Initializer) error {
    if err := initializer.RegisterRpc("custom_rpc_func_id", CustomRpc); err != nil {
        logger.Error("Unable to register: ", err)
        return err
    }
    if err := initializer.RegisterRpc("custom_rpc_func", src.CustomRpcc); err != nil {
        logger.Error("Unable to register: ", err)
        return err
    }
    if err := initializer.RegisterRpc("customRpcTest", src.CustomRpcTest); err != nil {
        logger.Error("Unable to register: ", err)
        return err
    }
   
    return nil
}


type Player struct {
    UserID   string `json:"userId"`    
    Username string `json:"username"`  
}

func CustomRpc(ctx context.Context, logger runtime.Logger, db *sql.DB, nk runtime.NakamaModule, payload string) (string, error) {
 
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

    return "Success", nil
}