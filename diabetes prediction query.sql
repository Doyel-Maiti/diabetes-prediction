
select * from diabetes


1)Retrieve the Patient_id and ages of all patients.
     select patient_id, TIMESTAMPDIFF(year,dob, now() ) -
     CASE WHEN (MONTH(dob) > MONTH(now())) OR (MONTH(dob) = MONTH(now()) AND DAY(dob) > DAY(now()))
     THEN 1 ELSE 0 END as age 
     from diabetes;


2)Select all female patients who are older than 30. 
     select employeename, TIMESTAMPDIFF(year,dob, now() ) -
     CASE WHEN (MONTH(dob) > MONTH(now())) OR (MONTH(dob) = MONTH(now()) AND DAY(dob) > DAY(now()))
     THEN 1 ELSE 0 END as age from diabetes
	 where 
     (TIMESTAMPDIFF(year,dob, now() ) -
     CASE WHEN (MONTH(dob) > MONTH(now())) OR (MONTH(dob) = MONTH(now()) AND DAY(dob) > DAY(now()))
     THEN 1 ELSE 0 END )>30
	 and gender ="female";


3)Calculate the average BMI of patients.
      select avg(bmi) as average_bmi from diabetes;

4)List patients in descending order of blood glucose levels.
      select employeename,blood_glucose_level from diabetes
      order by blood_glucose_level desc;

5)Find patients who have hypertension and diabetes. 
       select employeename ,hypertension, diabetes from diabetes where hypertension !=0 and diabetes !=0

6)Determine the number of patients with heart disease.
       select count(patient_id) as Heart_disease_patients from diabetes
       where heart_disease!=0
       
7)Group patients by smoking history and count how many smokers and non- 
smokers there are.
       select count(patient_id) as no_of_patients ,smoking_history from diabetes
       group by smoking_history;
       
8)Retrieve the Patient_id of patients who have a BMI greater than the average BMI.        
	   select patient_id,bmi  from diabetes 
       where bmi > (select avg(bmi) from diabetes);
    
9) Find the patient with the highest HbA1c level and the patient with the lowest 
HbA1clevel.
        (select employeename, HbA1c_level from diabetes
        order by HbA1c_level desc
        limit 1)
        union
        (select employeename, HbA1c_level from diabetes
        order by HbA1c_level 
        limit 1);
 
 
 11)Rank patients by blood glucose level within each gender group.
		SELECT 
		employeename,gender,blood_Glucose_Level,
		DENSE_RANK() OVER (PARTITION BY Gender ORDER BY Blood_Glucose_Level DESC) AS ranking
        FROM diabetes;
        
12) Update the smoking history of patients who are older than 40 to "Ex-smoker." 
		update diabetes
        set smoking_history='ex-smoker'
        where (TIMESTAMPDIFF(year,dob, now() ) -
        CASE WHEN (MONTH(dob) > MONTH(now())) OR (MONTH(dob) = MONTH(now()) AND DAY(dob) > DAY(now()))
		THEN 1 ELSE 0 END )> 40;

13)Insert a new patient into the database with sample data. 
		insert into diabetes
        values("sana","PT100200","Female","1998-01-19",0,0,"never",27,6,140,0);
        
14)Delete all patients with heart disease from the database.
       DELETE FROM Patients
       WHERE Heart Disease=1;
  
	
15)Find patients who have hypertension but not diabetes using the EXCEPT operator.
        select * from  diabetes where hypertension=1
        except
        select * from  diabetes where diabetes>0;
        
16)Define a unique constraint on the "patient_id" column to ensure its values are unique.         
        ALTER TABLE diabetes
        ADD CONSTRAINT unique_patient_id UNIQUE (Patient_id);


17) Create a view that displays the Patient_ids, ages, and BMI of patients. 
    
		CREATE VIEW Patient_BMI_View AS
        SELECT 
        Patient_id,
        TIMESTAMPDIFF(year,dob, now() ) -
        CASE WHEN (MONTH(dob) > MONTH(now())) OR (MONTH(dob) = MONTH(now()) AND DAY(dob) > DAY(now()))
		THEN 1 ELSE 0 END as age ,
        BMI
        FROM 
        diabetes ;
   select*from Patient_BMI_View;
       
        
               




