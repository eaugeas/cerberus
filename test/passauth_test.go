package test

import (
	"io/ioutil"
	"net/http"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPassauthErrNoPassword(t *testing.T) {
	client := &http.Client{}
	req, err := http.NewRequest("GET", "http://localhost:8080/passauth", nil)
	assert.Nil(t, err)

	res, err := client.Do(req)
	assert.Nil(t, err)

	p, err := ioutil.ReadAll(res.Body)
	assert.Nil(t, err)

	assert.Equal(t, http.StatusForbidden, res.StatusCode)
	assert.Equal(t, "Forbidden\n", string(p))
}

func TestPassauthErrNoWrongPassword(t *testing.T) {
	client := &http.Client{}
	req, err := http.NewRequest("GET", "http://localhost:8080/passauth", nil)
	assert.Nil(t, err)
	req.Header.Add("X-PASSWORD-AUTH", "INVALID")

	res, err := client.Do(req)
	assert.Nil(t, err)

	p, err := ioutil.ReadAll(res.Body)
	assert.Nil(t, err)

	assert.Equal(t, http.StatusForbidden, res.StatusCode)
	assert.Equal(t, "Forbidden\n", string(p))
}

func TestPassauthOK(t *testing.T) {
	client := &http.Client{}
	req, err := http.NewRequest("GET", "http://localhost:8080/passauth", nil)
	assert.Nil(t, err)
	req.Header.Add("X-PASSWORD-AUTH", "PASSWORD")

	res, err := client.Do(req)
	assert.Nil(t, err)

	p, err := ioutil.ReadAll(res.Body)
	assert.Nil(t, err)

	assert.Equal(t, http.StatusOK, res.StatusCode)
	assert.Equal(t, "OK\n", string(p))
}
