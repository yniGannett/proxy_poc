sub thorium_preflow {
    if (req.url.path ~ "^/thorium/") {
        set req.http.x-origin-expected-host = "thorium.gannettdigital.com";

        set req.url = regsub(req.url, "^/thorium/", "");

        ### Fastly Loadbalancing for thorium
        if(randombool(std.atoi(table.lookup(proxyapi_east_weights, "thorium")), 100)) {
            set req.http.RR = "east";
            set req.backend = F_thorium;
            if (req.http.Gannett-Debug) {
                set req.http.Gannett-Debug-Path = req.http.Gannett-Debug-Path " ; " "region: east" " " time.elapsed.msec "ms";
            }
        } else {
            set req.http.RR = "west";
            set req.backend = F_thorium_west;
            if (req.http.Gannett-Debug) {
                set req.http.Gannett-Debug-Path = req.http.Gannett-Debug-Path " ; " "region: west" " " time.elapsed.msec "ms";
            }
        }
    }
}

sub thorium_postflow {}