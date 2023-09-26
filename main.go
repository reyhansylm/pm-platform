package main

import (
    "context"
    "fmt"
    "database/sql"
    "github.com/heroiclabs/nakama-common/runtime"
) 


func main() {
    fmt.Println("Hello, World!")
}

func InitModule(ctx context.Context, logger runtime.Logger, db *sql.DB,nk runtime.NakamaModule,initializer runtime.Initializer) error {
    logger.Info("Hello World!")
    return nil
}
