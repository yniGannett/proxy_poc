sub argon_preflow {
    if (req.url.path ~ "^/argon/") {
        set req.http.x-origin-expected-host = "argon.gannettdigital.com";

        set req.url = regsub(req.url, "^/argon/", "");

        ### Fastly Loadbalancing for argon
        if(randombool(std.atoi(table.lookup(proxyapi_east_weights, "argon")), 100)) {
            set req.http.RR = "east";
            set req.backend = F_argon;
            if (req.http.Gannett-Debug) {
                set req.http.Gannett-Debug-Path = req.http.Gannett-Debug-Path " ; " "region: east" " " time.elapsed.msec "ms";
            }
        } else {
            set req.http.RR = "west";
            set req.backend = F_argon_west;
            if (req.http.Gannett-Debug) {
                set req.http.Gannett-Debug-Path = req.http.Gannett-Debug-Path " ; " "region: west" " " time.elapsed.msec "ms";
            }
        }
    }
}

sub argon_postflow {}