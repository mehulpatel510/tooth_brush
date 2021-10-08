**WD201 - Capstone Project – Tooth Brushing Management for Dentist patient**

**Introduction:**
    In the case of dentist-patient, generally, doctors assign brushing for a specific time when some special treatment is going on patient’s teeth. If the patient doing more or less brushing, then it affects the result of treatment. Our Plan is to develop a web application through which dentists assign a brushing schedule for specific time, morning/evening on each day. Patients complete the task with a specific time in seconds and update in the web portal (initial manually and then automatically IoT based). The doctor observes the brushing time of the patient, which helps for analysis of the treatment’s result.

**User roles & responsibility:**
    1.	Admin -	User management & Reporting
    2.	Dentist - Assign brushing task to patient, review the task completion & time of tooth brushing
    3.	Patient - Update the brushing task status

**The functionality of web portal:**
    1.	Admin can create a user for doctors.
    2.	Registration for patient and login for all users.
    3.	Doctor can assign brushing for specific time (seconds) task to specific patient.
    4.	Patient can update brushing schedule task status in portal daily.
    5.	View a history of completed brushing task-related his/her.
    6.	Doctor can observe the brushing task schedule summary on dashboard related to his/her patients and also detail history for a specific patient.
    7.	Admin can observe the no of users & a report brushing a teeth performance according to a task assign by the doctor.

**Schema:**
    
    User(id: integer, first_name: text, last_name: text, email: text, password_digest: text, user_role: text, status: boolean, created_at: datetime, updated_at: datetime)

    Schedule(id: integer, patient_id: integer, doctor_id: integer, schedule: text, duration: integer, assign_date: date, complete_date: date, status: boolean, created_at: datetime, updated_at: datetime)
    
    Taskdetail(id: integer, schedule_id: integer, task_date: date, schedule_slot: text, duration: integer, created_at: datetime, updated_at: datetime)

**Demonstration:**
    URL: https://mehulpatel-tooth-brush-wd201.herokuapp.com/
    
**Demo Account**
    
    admin account: 
        username: mehul@gmail.com 
        password: mehul

    doctor account: 
        username: ramesh@gmail.com 
        password: ramesh

    patient account: 
        username: haresh@gmail.com 
        password: haresh
    

**Screen shorts:**

**For admin:**
![image](https://user-images.githubusercontent.com/13706065/136441952-05c69b27-9f9b-48b5-a41b-a4db02e6947e.png)
![image](https://user-images.githubusercontent.com/13706065/136441998-5c827d17-4eb6-483d-a0d8-e1f9db5932d6.png)
![image](https://user-images.githubusercontent.com/13706065/136442083-3dd0e5b7-c758-4562-a5ab-1b49c39113b5.png)

**For Doctor:**
![image](https://user-images.githubusercontent.com/13706065/136440753-fed6cab4-20c1-4518-b00a-4644eefe9de4.png)
![image](https://user-images.githubusercontent.com/13706065/136440806-b6ae99b7-ecf1-49c0-9638-4950e6fc9d40.png)
![image](https://user-images.githubusercontent.com/13706065/136440871-eec37075-268d-4216-98b3-132c47d96565.png)

**For Patient:**
![image](https://user-images.githubusercontent.com/13706065/136442289-b4e58faa-48ab-48b8-9d59-347ec2a626a7.png)
![image](https://user-images.githubusercontent.com/13706065/136442364-ce838e84-6d34-45a2-ac13-642e38677cc8.png)




