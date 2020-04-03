#!/bin/bash
bq mk --table --time_partitioning_field first_flight_date_utc --clustering_fields region_pair --schema ./matching.X6b.json matching.X6b




