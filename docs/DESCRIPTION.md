# The Human Phenotype Ontology [(HPO)](https://hpo.jax.org/app/) 
> The Human Phenotype Ontology (HPO) provides a standardized vocabulary of phenotypic abnormalities encountered in human disease. Each term in the HPO describes a phenotypic abnormality, such as Atrial septal defect. The HPO is currently being developed using the medical literature, Orphanet, DECIPHER, and OMIM. HPO currently contains over 13,000 terms and over 156,000 annotations to hereditary diseases. The HPO project and others have developed software for phenotype-driven differential diagnostics, genomic diagnostics, and translational research. The HPO is a flagship product of the Monarch Initiative, an NIH-supported international consortium dedicated to semantic integration of biomedical and model organism data with the ultimate goal of improving biomedical research. The HPO, as a part of the Monarch Initiative, is a central component of one of the 13 driver projects in the Global Alliance for Genomics and Health (GA4GH) strategic roadmap.

Biobricks.ai transforms [HPO](https://hpo.jax.org/app/) into parquet files. 

# Data overview 
- This directory contains data obtained from [HPO](https://hpo.jax.org/app/).  
- The data is stored in parquet format. Descriptions for each column of each file in HPO can be found below.
- The data was downloaded from: https://hpo.jax.org/app/

# Data Table List 
- `genes_to_phenotype.parquet`
- `hp.parquet`
- `phenotype_to_genes.parquet`
- `phenotype.parquet`

# Description of Files 

### Data files

`genes_to_phenotype.parquet`
- entrez-gene-id. The Entrez gene ID that can be used to [look up](https://www.ncbi.nlm.nih.gov/gene) information about a gene.
- entrez-gene-symbol. The [Entrez gene symbol](https://www.ncbi.nlm.nih.gov/gene) associated with the Entrez gene ID.
- HPO-Term-ID. The HPO term ID for the term that describes a clinical abnormality.
- HPO-Term-Name. The name of the term corresponding to the HPO Term ID.
- Frequency-HPO. The frequency of the clinical abnormality in the HPO database.
- Additional Info from G-D source. Additional information available from other sources such as mim2gene and orphadata.
- G-D source. Source for additional information.
- disease-ID for link. Disease ID for link (eg, OMIM ID, ORPHA ID)

`hp.parquet`
- id. Identification number for the HPO database corresponding to the clinical abnormality.
- name. Name of the clinical abnormality corresponding to the ID number.
- parents. The HPO term IDs that this term is a child of.
- children. The HPO term IDs that this term is the parent of.
- ancestors. The HPO term IDs that this term is an ancestor of.
- obsolete. Whether or not this ID is obsolete.
- alt_id. Alternative ID numbers that this term corresponds to.
- comment. Comments on this term ID by HPO.
- consider.
- created_by. User that created the entry.
- creation_date. Date on which entry was created.
- def. Definition of term corresponding to HPO ID.
- is_a. Describes the relationship of this HPO term ID to other HPO term IDs. The relationship is transitive, meaning that annotations are inherited up all paths to the root.
- property value.
- replaced_by. HPO term ID for the term that replaced this term ID.
- subset. 
- synonym. Other phrases that this term is a synonym for. 
- xref. ID for cross-referencing to another database. 

`phenotype_to_genes.parquet`
- HPO-id. The HPO term ID for the term that describes a clinical abnormality.
- HPO label. The name of the term corresponding to the HPO Term ID.
- entrez-gene-id. The Entrez gene ID that can be used to [look up](https://www.ncbi.nlm.nih.gov/gene) information about a gene.
- entrez-gene-symbol. The [Entrez gene symbol](https://www.ncbi.nlm.nih.gov/gene) associated with the Entrez gene ID.
- Additional Info from G-D source. Additional information available from other sources such as mim2gene and orphadata.
- G-D source. Source for additional information.
- disease-ID for link. Disease ID for link (eg, OMIM ID, ORPHA ID)

`phenotype.parquet`
- DatabaseID. Identification number and database to which the entry for the disease corresponds.
- DiseaseName. Name of the disease.
- Qualifer. This optional field can be used to qualify the annotation. The only allowed values of this field are NOT and empty string. NOT: The disorder being annotated is NOT characterized by the feature associated with HPO_ID in column 5. Note that annotations with the NOT modifier are moved to separate file!
- HPO_ID. This field is for the HPO identifier for the term attributed to the DB_Object_ID.
- Reference. This required field indicates the source of the information used for the annotation. This may be the clinical experience of the annotator or may be taken from an article as indicated by a PubMed id. Each collaborating center of the Human Phenotype Ontology consortium is assigned a HPO:Ref id. In addition, if appropriate, a PubMed id for an article describing the clinical abnormality may be used.
- Evidence. This required field indicates the level of evidence supporting the annotation. Annotations that have been extracted by parsing the Clinical Features sections of the omim.txt file are assigned the evidence code IEA (inferred from electronic annotation). Please note that you need to contact OMIM in order to reuse these annotations in other software products. Other codes include PCS for published clinical study. This should be used for information extracted from articles in the medical literature. Generally, annotations of this type will include the PubMed id of the published study in the DB_Reference field. ICE can be used for annotations based on individual clinical experience. This may be appropriate for disorders with a limited amount of published data. This must be accompanied by an entry in the DB:Reference field denoting the individual or center performing the annotation together with an identifier. For instance, GH:007 might be used to refer to the seventh such annotation made by a specialist from Gotham Hospital (assuming the prefix GH has been registered with the HPO). Finally we have TAS, which stands for “traceable author statement”, usually reviews or disease entries (e.g. OMIM) that only refers to the original publication.
- Onset. A term-id from the HPO-sub-ontology below the term Age of onset.
- Frequency. Frequency of the abnormality.
- Modifier. A term from the [Clinical modifier subontology](https://hpo.jax.org/app/browse/term/HP:0012823)
- Aspect. One of P (Phenotypic abnormality), I (inheritance), C (onset and clinical course).
- Biocuration. This refers to the center or user making the annotation and the date on which the annotation was made; format is YYYY-MM-DD. Multiple entries can be separated by a semicolon if an annotation was revised, e.g., HPO:skoehler[2010-04-21];HPO:lcarmody[2019-06-02]