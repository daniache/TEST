VET CLINIC ORACLE SQL DATABASE

This project involves designing and implementing an information system for a Vet Clinic, aimed at addressing inefficiencies in the clinic’s current processes, such as appointment management, pet registration, and medical record maintenance. It uses a central database to make it easier for the clinic staff and management to enter, find, and use information more efficiently. 

Note: this project does not have a web interface.

![pet list](https://github.com/user-attachments/assets/a166c7dd-23dd-41ee-90e7-11a80d4ddeba) 

![appt](https://github.com/user-attachments/assets/f13158b4-b877-4fd3-a247-4c93d541203a)

TECHNOLOGIES USED

1. Programming and Database Tools:

   - SQL: For database creation, data insertion, and querying.
   - Oracle Database: To manage and store the system's data.

2. System Design Tools:

   - Use Case Diagrams (UCD): For visualizing system interactions.
   - Entity Relationship Diagrams (ERD): For database design.

3. Project Management Tools:

   - Microsoft Teams: For collaboration, task tracking, and document management.

4. Normalization Techniques:

   - Normalization to 3NF for efficient database design
  

FUNCTIONALITIES

The system is designed to provide the following functionalities:

For Pet Owners:

  - Register a new pet owner and their pets.
  - Add a new pet to an existing owner's profile.
  - Book, reschedule, and cancel appointments.
  - Receive automated reminders for upcoming appointments or cancellations.
  - View appointment confirmations via email.

For Veterinary Staff:

  - Access and update medical records for pets.
  - View upcoming appointments.
  - Record pet diagnoses and treatments, including prescriptions.

For Receptionists:

  - Manage appointment schedules and cancellations.
  - Process payments and refunds for appointments.
  - Respond to inquiries from pet owners.


System-Wide Functionalities:

  - Automated fees calculation for cancellations and consultations.
  - Unique ID generation for pets and appointments.
  - Backup and recovery mechanisms to prevent data loss.
  - Role-based access control to restrict data access based on user roles.


How to invoke the application

  1. Set up the database:
      - Create the database schema using the SQL scripts in the folder.
      - Use an SQL client such as Oracle SQL Developer to run the scripts.
      - Populate the database with sample data using INSERT statements.

  2. Run database queries:
      - Execute the provided SQL queries manually to interact with the database.
  
  3. Test functionalities:

      - Use SQL commands to simulate various operations such as registering pets, booking appointments, and updating medical records.
