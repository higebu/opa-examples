package main

default allow = false

allow := true {
    count(violation) == 0
}

allowed_cidrs = ["192.168.0.0/16", "172.16.0.0/12", "10.0.0.0/8"]

violation[msg] {
  destinations := {x | input.protocols.static.route[x]}
  matches := net.cidr_contains_matches(allowed_cidrs, destinations)
  matched := { cidr | cidr := matches[_][1]}
  not_matched := destinations - matched
  count(not_matched) > 0
  msg := sprintf("static route contains not allowed cidrs: %s", [not_matched])
}
