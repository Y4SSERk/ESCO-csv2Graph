#!/bin/bash
# ESCO Graph Production Deployment Script
# Usage: ./deploy_esco_graph.sh

set -e  # Exit on any error

echo "=== Starting ESCO Graph Production Deployment ==="
echo "================================================="

# Configuration
NEO4J_IMPORT_DIR="/var/lib/neo4j/import"
DATA_DIR="./data/processed"
NEO4J_DIR="./neo4j"

# Validate required files
echo "STEP 1: Validating export files..."
required_files=(
    "nodes_occupations.csv"
    "nodes_skills.csv" 
    "relationships_occupation_skill.csv"
)

for file in "${required_files[@]}"; do
    if [ ! -f "$DATA_DIR/$file" ]; then
        echo "ERROR: Missing required file: $file"
        exit 1
    fi
done

# Count records for estimation
NODE_COUNT=$(($(wc -l < "$DATA_DIR/nodes_occupations.csv" 2>/dev/null || echo 0) + $(wc -l < "$DATA_DIR/nodes_skills.csv" 2>/dev/null || echo 0)))
REL_COUNT=$(wc -l < "$DATA_DIR/relationships_occupation_skill.csv" 2>/dev/null || echo 0)

# Subtract headers from counts
NODE_COUNT=$((NODE_COUNT - 2))
REL_COUNT=$((REL_COUNT - 1))

# Estimate import time (rough calculation)
ESTIMATED_MINUTES=$(( (NODE_COUNT + REL_COUNT) / 2000 ))

echo ""
echo "DEPLOYMENT OVERVIEW:"
echo "  - Total Nodes: $NODE_COUNT"
echo "  - Total Relationships: $REL_COUNT"
echo "  - Estimated Time: $ESTIMATED_MINUTES minutes"
echo ""

echo "NEO4J CONFIGURATION RECOMMENDATIONS:"
echo "  - dbms.memory.heap.initial_size=2G"
echo "  - dbms.memory.heap.max_size=4G" 
echo "  - dbms.memory.pagecache.size=1G"
echo "  - dbms.security.allow_csv_import_from_file_urls=true"
echo ""

echo "IMPORT INSTRUCTIONS:"
echo "  1. Copy CSV files to Neo4j import directory:"
echo "     cp $DATA_DIR/*.csv $NEO4J_IMPORT_DIR/"
echo "  2. Run constraints:"
echo "     cat $NEO4J_DIR/constraints.cypher | cypher-shell"
echo "  3. Run indexes:"
echo "     cat $NEO4J_DIR/indexes.cypher | cypher-shell"
echo "  4. Import nodes:"
echo "     cat $NEO4J_DIR/import_optimized.cypher | cypher-shell"
echo "  5. Import relationships:"
echo "     cat $NEO4J_DIR/import_relationships_optimized.cypher | cypher-shell"
echo ""

echo "SUCCESS: Deployment script ready. Follow the instructions above."
