SELECT tab0.v1 AS v1 , tab6.v7 AS v7 , tab4.v5 AS v5 , tab5.v6 AS v6 , tab3.v4 AS v4 , tab2.v3 AS v3 , tab7.v8 AS v8 , tab1.v2 AS v2 
 FROM    (SELECT obj AS v1 
	 FROM wsdbm__follows$$1$$
	 
	 WHERE sub = 'wsdbm:User479483'
	) tab0
 JOIN    (SELECT sub AS v1 , obj AS v2 
	 FROM wsdbm__likes$$2$$
	) tab1
 ON(tab0.v1=tab1.v1)
 JOIN    (SELECT obj AS v3 , sub AS v2 
	 FROM rev__hasReview$$3$$
	
	) tab2
 ON(tab1.v2=tab2.v2)
 JOIN    (SELECT obj AS v4 , sub AS v3 
	 FROM rev__reviewer$$4$$
	
	) tab3
 ON(tab2.v3=tab3.v3)
 JOIN    (SELECT obj AS v5 , sub AS v4 
	 FROM wsdbm__friendOf$$5$$
	
	) tab4
 ON(tab3.v4=tab4.v4)
 JOIN    (SELECT sub AS v5 , obj AS v6 
	 FROM wsdbm__makesPurchase$$6$$
	
	) tab5
 ON(tab4.v5=tab5.v5)
 JOIN    (SELECT obj AS v7 , sub AS v6 
	 FROM wsdbm__purchaseFor$$7$$
	
	) tab6
 ON(tab5.v6=tab6.v6)
 JOIN    (SELECT sub AS v7 , obj AS v8 
	 FROM sorg__author$$8$$
	) tab7
 ON(tab6.v7=tab7.v7)


++++++Tables Statistic
sorg__author$$8$$	0	VP	sorg__author/
	VP	<sorg__author>	40060
------
wsdbm__makesPurchase$$6$$	0	VP	wsdbm__makesPurchase/
	VP	<wsdbm__makesPurchase>	1499988
------
wsdbm__likes$$2$$	0	VP	wsdbm__likes/
	VP	<wsdbm__likes>	1124672
------
wsdbm__purchaseFor$$7$$	0	VP	wsdbm__purchaseFor/
	VP	<wsdbm__purchaseFor>	1500000
------
rev__reviewer$$4$$	0	VP	rev__reviewer/
	VP	<rev__reviewer>	1500000
------
rev__hasReview$$3$$	0	VP	rev__hasReview/
	VP	<rev__hasReview>	1476843
------
wsdbm__follows$$1$$	0	VP	wsdbm__follows/
	VP	<wsdbm__follows>	32736135
------
wsdbm__friendOf$$5$$	0	VP	wsdbm__friendOf/
	VP	<wsdbm__friendOf>	45092208
------
