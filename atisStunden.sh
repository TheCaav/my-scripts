#!/bin/sh

brave localhost:8080 && brave tine.informatik.kit.edu
ssh -N -L 8080:worktime.informatik.kit.edu:443 atis;
