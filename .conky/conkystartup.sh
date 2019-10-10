#!/bin/bash

sleep 10

conky -b -c ~/etc/conky/.conkyrc-a &

conky -b -c ~/etc/conky/.conkyrc-b &
