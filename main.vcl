include configs;

sub vcl_recv {
    ...
    call preflow;
    ...
}

sub vcl_fetch {
    ...
    call postflow;
    ...
}