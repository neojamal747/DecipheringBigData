-- Students
CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY, -- Auto-incrementing student ID
    student_name VARCHAR(100) NOT NULL,
    exam_score INT NOT NULL,
    support BOOLEAN NOT NULL, -- TRUE for 'Yes', FALSE for 'No'
    date_of_birth DATE NOT NULL
);

-- Courses
CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY, -- Unique ID for each course
    course_name VARCHAR(100) NOT NULL UNIQUE --  Only Unique Course Names
);

-- Student-Course (Associative Table)
CREATE TABLE StudentCourse (
    student_course_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

-- Course-Teacher (Associative Table)
CREATE TABLE CourseTeacher (
    course_teacher_id SERIAL PRIMARY KEY,
    course_id INT NOT NULL,
    teacher_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

-- Teacher-Department
CREATE TABLE TeacherDepartment (
    teacher_department_id SERIAL PRIMARY KEY,
    teacher_name VARCHAR(100) NOT NULL UNIQUE, -- Only Unique so each teacher is only listed 1 time
    department_name VARCHAR(100) NOT NULL
);