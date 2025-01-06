#!/bin/bash
DOCS_ROOT=dist/docs/
REPO_NAME="ooni/backend"
MAIN_BRANCH="master"
COMMIT_HASH=$(git rev-parse --short HEAD)

mkdir -p $DOCS_ROOT

strip_title() {
    # Since the title is already present in the frontmatter, we need to remove
    # it to avoid duplicate titles
    local infile="$1"
    cat $infile | awk 'BEGIN{p=1} /^#/{if(p){p=0; next}} {print}'
}

generate_doc() {
    local order="$1"
    local slug="$2"
    local input_file="$3"
    local output_file="$4"
    local title="$5"
    local description="$6"

    cat <<EOF>"$DOCS_ROOT/$output_file"
---
# Do not edit! This file is automatically generated
# version: $REPO_NAME/$input_file:$COMMIT_HASH
title: $title
description: $description
slug: $slug
sidebar:
    order: $order
---
EOF
    echo "[edit file](https://github.com/$REPO_NAME/edit/$MAIN_BRANCH/$input_file)" >> "$DOCS_ROOT/$output_file"
    strip_title "$input_file" >> "$DOCS_ROOT/$output_file"
}

# Generate documentation files
generate_doc 0 "backend" "README.md" "00-index.md" "OONI Backend" "OONI Backend documentation"
generate_doc 1 "backend/ooniapi" "ooniapi/README.md" "01-ooniapi-guidelines.md" "OONI API Guidelines" "OONI API development guidelines"
generate_doc 2 "backend/ooniapi/services" "docs/API.md" "02-ooniapi-services.md" "OONI API Services" "OONI API Services documentation"
generate_doc 3 "backend/test-helpers" "docs/TestHelpers.md" "03-test-helpers.md" "OONI Test Helpers" "OONI Test helpers documentation"
generate_doc 4 "backend/fastpath" "docs/Fastpath.md" "04-backend-fastpath.md" "OONI Fastpath" "OONI Fastpath documentation"
generate_doc 5 "backend/measurement-uploader" "docs/MeasurementUploader.md" "05-backend-measurement-uploader.md" "OONI Measurement Uploader" "OONI measurement uploader documentation"
generate_doc 6 "backend/systemd-timers" "docs/SystemdTimers.md" "06-backend-systemd-timers.md" "Systemd Timers" "Systemd timers documentation"
generate_doc 7 "backend/analysis" "docs/BackendAnalysis.md" "07-backend-analysis.md" "Backend Analysis" "Backend Analysis documentation"
generate_doc 8 "backend/database" "docs/Database.md" "08-backend-database.md" "Database" "OONI Database schemas, guidelines and more"
generate_doc 9 "backend/other-components" "docs/OtherComponents.md" "09-backend-other-components.md" "Other components" "Other components, nginx, jupyter notebooks, etc. "
generate_doc 10 "web-uis" "docs/WebUIs.md" "10-web-uis.md" "Web UIs" "Web UIs"
generate_doc 11 "backend/ci-cd" "docs/CI-CD.md" "11-ci-cd.md" "CD/CI" "Continous Integration, Continous Delivery workflows"
generate_doc 12 "backend/bridges" "docs/Bridges.md" "12-bridges.md" "OONI Bridges" "OONI Bridges"
