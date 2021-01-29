#!/bin/bash

# create sqlite database instance
sqlite3 ./test.db << EOF

# import flat files(tsv) as tables in test.db
.mode tabs ;
.import "./seqtable_test.tsv" seqtable 
.import "./metadata_test.tsv" metadata 

# create indices for seqtable on sample_processing_id and jun_aa_len column
CREATE INDEX seq_ind ON seqtable(sample_processing_id);
CREATE INDEX jun_aa_len ON seqtable(junction_aa_length);

# create index for metadata table
CREATE INDEX meta_ind ON metadata(sample_processing_id,subject_id, sex, disease_diagnosis, disease_stage, intervention);

EOF
