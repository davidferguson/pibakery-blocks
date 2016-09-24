#!/bin/bash
service rpcbind start
mkdir -p $2
mount $1 $2