package main

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

func main() {
	r := gin.Default()

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, "pang")
	})

	r.GET("/getUser/:name", func(c *gin.Context) {
		name := c.Param("name")
		if name == "" {
			name = "jerry"
		}

		c.JSON(http.StatusOK, map[string]interface{}{"name": name})
	})

	r.Run(":8182")
}
