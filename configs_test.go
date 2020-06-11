package main

import (
    "net/http"
    "testing"
    fastly "github.com/GannettDigital/go-fastly-tests"
)


func TestargonStandard(t *testing.T) {
    t.Parallel()
    var tests = []fastly.Test{
        fastly.Status{
            Request: fastly.Request{
                Description:"argon proxy status is 200",
                Scheme: "https://",
                Host: "api.usatoday.com",
                Path: "/argon/status",
                UA: "",
                Referer: "",
                Cookies: []*http.Cookie{},
                Headers: http.Header{},
            },
            Status: http.StatusOK,
        },
        fastly.Header{
            Request: fastly.Request{
                Description: "surrogate key is correctly appended",
                Scheme: "https://",
                Host: "api.usatoday.com",
                Path: "/argon/status",
                UA: "",
                Referer: "",
                Cookies: []*http.Cookie{},
                Headers: http.Header{},
            },
            Status: http.StatusOK,
            Headers: http.Header{
                "Surrogate-Key": []string{
                    "argon",
                },
            },
            MatchType: fastly.PartialMatch{},
        },       
    }
    for _, test := range tests {
		test.Execute(t)
	}
}

func TestthoriumStandard(t *testing.T) {
    t.Parallel()
    var tests = []fastly.Test{
        fastly.Status{
            Request: fastly.Request{
                Description:"thorium proxy status is 200",
                Scheme: "https://",
                Host: "api.usatoday.com",
                Path: "/thorium/status",
                UA: "",
                Referer: "",
                Cookies: []*http.Cookie{},
                Headers: http.Header{},
            },
            Status: http.StatusOK,
        },
        fastly.Header{
            Request: fastly.Request{
                Description: "surrogate key is correctly appended",
                Scheme: "https://",
                Host: "api.usatoday.com",
                Path: "/thorium/status",
                UA: "",
                Referer: "",
                Cookies: []*http.Cookie{},
                Headers: http.Header{},
            },
            Status: http.StatusOK,
            Headers: http.Header{
                "Surrogate-Key": []string{
                    "thorium",
                },
            },
            MatchType: fastly.PartialMatch{},
        },       
    }
    for _, test := range tests {
		test.Execute(t)
	}
}
