#!/usr/bin/env bash

UPDATES=$(checkupdates 2>/dev/null | wc -l)

echo ${UPDATES}
