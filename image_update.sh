#!/bin/zsh

LOGFILE="docker_update.log"
echo "$(date) - Docker update script started" | tee -a "$LOGFILE"

find . -type f \( -name "*.yaml" -o -name "*.lml" \) | while read -r file; do
    dir=$(dirname "$file")
    cd "$dir" || continue
    
    echo "Checking directory: $dir" | tee -a "$LOGFILE"
    
    # Get currently running images
    RUNNING_IMAGES=$(docker compose ps --format "{{.Image}}" | sort -u)
    echo "Running images: $RUNNING_IMAGES"
    
    # Pull only images that are in use
    UPDATED_IMAGES=()
    for image in $RUNNING_IMAGES; do
        echo "Checking for updates: $image"
        if docker pull "$image" 2>&1 | grep -q "Downloaded newer image"; then
            UPDATED_IMAGES+=("$image")
        fi
    done
    
    if [ ${#UPDATED_IMAGES[@]} -gt 0 ]; then
        echo "$(date) - Updates found in $dir for: ${UPDATED_IMAGES[*]}" | tee -a "$LOGFILE"
        
        echo "Stopping and updating containers in $dir"
        docker compose down
        for image in "${UPDATED_IMAGES[@]}"; do
            docker pull "$image"
        done
        docker compose up -d
        
        echo "$(date) - Update completed in $dir" | tee -a "$LOGFILE"
    else
        echo "$(date) - No updates found in $dir" | tee -a "$LOGFILE"
    fi
    
    cd - > /dev/null
done

echo "$(date) - Docker update script completed" | tee -a "$LOGFILE"

