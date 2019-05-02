# ComplEx - Complex Embeddings for Simple Link Prediction


### Knowledge Graph Embedding Project for CSCI548@USC
This code base implements the following paper:

##### Theo Trouillon, Johannes Welbl, Sebastian Riedel, Eric Gaussier and Guillaume Bouchard. Complex Embeddings for Simple Link Prediction. Proceedings of the 33rd International Conference on Machine Learning, New York, NY,  2016. https://arxiv.org/pdf/1606.06357.pdf


##### This code base simplifies/refactors this GitHub repo: https://github.com/mana-ysh/knowledge-graph-embeddings to conform to a class project

##### Youtube Video Link: https://youtu.be/zGdGrcPvwAk *also shows how to run Jupyter notebook*

Package requirements: numpy, scipy, dill

---
### Knowledge Graph Embedding Task
Knowledge Graphs (KG) typically contain only a small subset of all possible facts. This necessitates filling in the missing information. This process is known as *link prediction* or *knowledge graph completion*. KG models accomplish this by learning the embeddings of the entities and relations which can be used later for link prediction or KG completion.

Example (subject, relation, object) (s, r, o) triples 
```text
Man isTypeOf Animal
Dog isTypeOf Animal
Texas isStateIn America
Trump isEmployedBy Unites States Government
Obama bornIn Hawaii
```
Entities and Relations From Above:

| Entities        | Relations |
|:-------------:|:-----------:| 
| Man | isTypeOf |
| Dog | isStateIn | 
| Texas | isEmployedBy |
| Trump | bornIn |
| Obama | |

Typical bi-linear KG embedding models learn embeddings to optimize a score function, i.e. RESCAL (Nickel et al., 2011). Each entity is represented by vector embedding of *m* dimensions, each relation embedding represented by *m x m* matrix, which can de diagonalized to reduce a dimension, i.e. DistMult (Yang et al., 2015). Models utilize varying score and loss functions, as well as different training methods. Negative training samples need to be Introduced. 

### Overview of ComplEx

Building on previous models such as RESCAL and DistMult, ComplEx introduces a complex number for the embeddings. By doing so this captures some the asymmetry of knowledge graphs thus boosting performance (e.g. *dog* is an *animal* but an *animal* is not a *dog*). Earlier models would assign similar scores to both *dog* is an *animal* and *animal* is a *dog*.

---

### Datasets:
This code has been tested on the FB15k and WN18 datasets. 

Note: To conform to standards for the class project I modified the relations and entities input files, different from original code. If you wish to conform to original codes relation and entity files (suggested), substitute commented code in dataset.py with uncommented (line 65 with line 71) to not read the relation number (this is done under the hood in the code and thus not required)

Entities Example:
```text
/m/06rf7	0
/m/0c94fn	1
/m/016ywr	2
/m/01yjl	3
```

Relations Example:
```text
/sports/sports_team/roster./soccer/football_roster_position/player	8
/business/company_type/companies_of_this_type	9
/tv/tv_program/regular_cast./tv/regular_tv_appearance/character	10
/architecture/structure/address./location/mailing_address/citytown	11
```

Train/Validate/Test Example:
```text
/m/017dcd	/m/06v8s0	/tv/tv_program/regular_cast./tv/regular_tv_appearance/actor
/m/07s9rl0	/m/0170z3	/media_common/netflix_genre/titles
/m/01sl1q	/m/044mz_	/award/award_winner/awards_won./award/award_honor/award_winner
/m/0cnk2q	/m/02nzb8	/soccer/football_team/current_roster./sports/sports_team_roster/position
```
---

### Running the code 

##### (please load the Jupyter Notebook sample *complex_notebook.ipynb* from the code repository to aid you in running the code for the first time):
1. Initialize a model
```python
algorithm = ComplEx()
```
2. Load the Data Set
```python
train_file_names = {"train": "train.txt",
# Optional          "valid": "valid.txt",
# Optional          "whole": "whole.txt",
                    "relations": "relation2id.txt",
                    "entities": "entity2id.txt"}

algorithm.read_dataset(train_file_names)
```
3. Learn the embeddings (i.e train model) *Note:* you can pass empty dictionary, there are default parameters for everything
```python
parameters = {"mode": 'single',
              "epoch": 3,
              "batch": 128,
              "lr": 0.05,
              "dim": 200,            
              "negative": 3,         
              "opt": 'adagrad',
              "l2_reg": 0.001,
              "gradclip": 5,
              'filtered': True}
              
# Other parameters not listed:
# margin
# cp_ratio
# metric
# nbest
# batch
# save_step

algorithm.learn_embeddings(parameters)
```
4. Save the model (Use if you want to save training model for use later). Some models will take days to train!
```python
algorithm.save_model("complex.mod")
```
5. Load a model (Use if you saved a model above, allows you to have to not rerun training of model)
```python
algorithm.load_model("complex.mod")
```
6. Retrieve embeddings
```python
test_subs = ['/m/07z1m', '/m/03gqgt3', '/m/01c9f2']
print(algorithm.retrieve_entity_embeddings(test_subs))
```
7. Retrieve scoring matrix (each row is the s,r scored against each other entity)
```python
sm = algorithm.retrieve_scoring_matrix(test_subs, test_rels)
print(sm)
```
8. Evaluate model
```python
evaluate_file_names = {"test": input_file_path + "test.txt",
                       "whole": input_file_path + "whole.txt"}  # Optional
all_res = algorithm.evaluate(evaluate_file_names)
for metric in sorted(all_res.keys()):
    print('{:20s}: {}'.format(metric, all_res[metric]))
```
---
### Evaluation Results
##### WN18
| Source        | MRR (filtered) | MRR (raw) | Hits@1 (Filtered) | Hits@3 (Filtered)
| ------------- |:--------:|:------:|:------:|:------:| 
| Paper      | 94.1 | 58.7 | 93.6 | 94.5
| Code      | 94.3 | 58.2 | 94.0 | 94.5
##### FB15k
| Source        | MRR (filtered) | MRR (raw) | Hits@1 (Filtered) | Hits@3 (Filtered)
| ------------- |:--------:|:------:|:------:|:------:| 
| Paper      | 69.2 | 58.7 | 59.9 | 75.9
| Code      | 69.0 | 58.6 | 59.5 | 76.1

---

### References
1. Maximilian Nickel, Volker Tresp, and Hans-Peter Kriegel. A three-way model for collective learning on multi-relational data. Proceedings of the 28th international conference on machine learning (ICML-11), pp. 809–816, 2011.

2. Maximilian Nickel, Lorenzo Rosasco, and Tomaso A Poggio. Holographic embeddings of knowledge graphs. In Proceedings of the Thirtieth AAAI Conference on Artificial Intelligence, February 12-17, 2016, Phoenix, Arizona, USA., pp. 1955–1961, 2016. URL http://www.aaai.org/ocs/index.php/AAAI/AAAI16/paper/view/12484.

3. Theo Trouillon, Johannes Welbl, Sebastian Riedel, Eric Gaussier and Guillaume Bouchard. Complex Embeddings for Simple Link Prediction. Proceedings of the 33rd International Conference on Machine Learning, New York, NY,  2016. https://arxiv.org/pdf/1606.06357.pdf

4. Bishan Yang, Wen-tau Yih, Xiaodong He, Jianfeng Gao, and Deng, Li. Embedding entities and relations for learning and inference in knowledge bases. CoRR, abs/1412.6575, 2014. URL http://arxiv.org/abs/1412.6575.
