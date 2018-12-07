PRAGMA foreign_keys=off;

BEGIN TRANSACTION;

CREATE TABLE Applicants(
  name varchar(80) NOT NULL,
  social int unsigned NOT NULL,
  age int unsigned NOT NULL CHECK(age > 18 AND age < 70),
  phone int unsigned,
  CONSTRAINT keys
    PRIMARY KEY(social)
);

CREATE TABLE Inmate(
  name varchar(80) NOT NULL,
  sentence_length int unsigned NOT NULL CHECK (sentence_length > 0),
  gender varchar(1) NOT NULL CHECK (gender = "M" or gender = "F"),
  prison_id int unsigned NOT NULL CHECK (prison_id > 0),
  bail int unsigned,
  death_row_eligible BOOLEAN NOT NULL,
  parole_eligibility BOOLEAN NOT NULL,

  /*Time is in 24hr clock so 1800 == 6 PM and 630 == 6:30 AM*/

  wake_up int unsigned NOT NULL,
  brunch_time int unsigned NOT NULL,
  free_time int unsigned,
  yard_time int unsigned,
  visit int unsigned,
  dinner_time int unsigned NOT NULL,
  sleep_time int unsigned NOT NULL,
  CONSTRAINT keys
    PRIMARY KEY(prison_id)
);

CREATE TABLE Crimes_Committed(
  crime varchar(80) NOT NULL,
  prison_id int unsigned NOT NULL,
  CONSTRAINT keys
    PRIMARY KEY(prison_id, crime),
    FOREIGN KEY(prison_id) REFERENCES Inmate(prison_id)
);

/*CELL NOW INCLUDES THE BLOCK LETTER*/

CREATE TABLE Cell(
  size int unsigned NOT NULL,
  cell_number int unsigned NOT NULL,
  block_letter varchar(1) NOT NULL,
  CONSTRAINT keys
    PRIMARY KEY(block_letter, cell_number),
    FOREIGN KEY(block_letter) REFERENCES Block(block_letter)
);

/*BLOCK NOW INCLUDES LETTER NOT NUMBER*/

CREATE TABLE Block(
  block_letter varchar(1) NOT NULL,
  security_level int unsigned NOT NULL,
  CONSTRAINT keys
    PRIMARY KEY(block_letter)
);

/*LIVES NOW INCLUDES BLOCK LETTER*/

CREATE TABLE Lives(
  cell_number int unsigned NOT NULL,
  prison_id int unsigned NOT NULL,
  block_letter varchar(1) NOT NULL,
  CONSTRAINT keys
    PRIMARY KEY(cell_number, prison_id, block_letter),
    FOREIGN KEY(cell_number, block_letter) REFERENCES Cell(cell_number, block_letter),
    FOREIGN KEY(prison_id) REFERENCES Inmate(prison_id)
);

CREATE TABLE Cell_Block(
  cell_number int unsigned NOT NULL,
  block_letter varchar(1) NOT NULL,
  CONSTRAINT keys
    FOREIGN KEY(cell_number, block_letter) REFERENCES Cell(cell_number, block_letter)
);

CREATE TABLE Warden(
  name varchar(80) NOT NULL,
  start_date int unsigned NOT NULL,
  salary int unsigned,
  id int unsigned NOT NULL,
  password varchar(80) NOT NULL,
  CONSTRAINT keys
    PRIMARY KEY(name)
);

CREATE TABLE Manages(
  warden_name varchar(80) NOT NULL,
  employee_id int unsigned NOT NULL,
  CONSTRAINT keys
    FOREIGN KEY(warden_name) REFERENCES Warden(name),
    FOREIGN KEY(employee_id) REFERENCES Employee(employee_id)
    ON DELETE CASCADE
);

CREATE TABLE Warden_Phone(
  name varchar(80) NOT NULL,
  phone_number int unsigned NOT NULL,
  CONSTRAINT keys
    PRIMARY KEY(phone_number),
    FOREIGN KEY(name) REFERENCES Warden(name)
);

CREATE TABLE Employee(
  employee_name varchar(80) NOT NULL,
  employee_id int unsigned NOT NULL,
  password varchar(80) NOT NULL,
  start_date int unsigned NOT NULL,
  CONSTRAINT keys
    PRIMARY KEY(employee_id)
);

CREATE TABLE Employee_Phone(
  employee_id int unsigned NOT NULL,
  phone_number int unsigned NOT NULL,
  CONSTRAINT keys
    PRIMARY KEY(phone_number),
    FOREIGN KEY(employee_id) REFERENCES Employee(employee_id)
    ON DELETE CASCADE
);

CREATE TABLE Guard(
  employee_id int unsigned NOT NULL,
  salary int unsigned,
  CONSTRAINT keys
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
    ON DELETE CASCADE
);

CREATE TABLE Cook(
  employee_id int unsigned NOT NULL,
  salary int unsigned,
  CONSTRAINT keys
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
    ON DELETE CASCADE
);

CREATE TABLE Guard_Shift(
  block_letter varchar(1) NOT NULL,
  employee_id int unsigned NOT NULL,
  CONSTRAINT keys
    FOREIGN KEY (block_letter) REFERENCES Block(block_letter),
    FOREIGN Key (employee_id) REFERENCES Employee(employee_id)
    ON DELETE CASCADE
);


INSERT INTO Warden VALUES("Wilson Fisk", 01251996, 275000, 110100100, "password");

INSERT INTO Warden_Phone VALUES("Wilson Fisk", 1111973000);

INSERT INTO Employee VALUES("Doug", 123456, "123", 12012008);
INSERT INTO Employee VALUES("Margie Farmer", 792332, "DfaDsZCO", 12012008);
INSERT INTO Employee VALUES("Curtis Evans", 030107, "nPu4PPBz", 12012008);
INSERT INTO Employee VALUES("Angela Quinn", 016094, "HNuhyGY0", 12012008);
INSERT INTO Employee VALUES("Nellie Neal", 319866, "qq1ySsSf", 12012008);
INSERT INTO Employee VALUES("Jared Porter", 474752, "1qNbOn9s", 12012008);
INSERT INTO Employee VALUES("Lonnie Roy", 456687, "2Cp5ldpQ", 12012008);
INSERT INTO Employee VALUES("Max Sutton", 002252, "CDaAe53n", 09232012);
INSERT INTO Employee VALUES("Kimberly Castillo", 203384, "xPxL1fNa", 09122013);
INSERT INTO Employee VALUES("Robin Hodges", 653828, "rEINT1zf", 04052011);
INSERT INTO Employee VALUES("Don Moody", 909698, "xCV5PuaV", 04052011);
INSERT INTO Employee VALUES("Pat Rivera", 885600, "XkVqXS7W", 04052011);
INSERT INTO Employee VALUES("Laurence Lambert", 816800, "PZDarmbK", 04052011);
INSERT INTO Employee VALUES("Olivia Cobb", 479491, "uSD45Lrq", 04052011);
INSERT INTO Employee VALUES("Dennis May", 634360, "uSD45Lrq", 05092019);
INSERT INTO Employee VALUES("Elbert Walker", 126432, "QDxO75v2", 01092009);
INSERT INTO Employee VALUES("Wilson Hayes", 994823, "el4DBg7t", 01012009);
INSERT INTO Employee VALUES("Lester Shelton", 685385, "qLiIMMU4", 01012009);
INSERT INTO Employee VALUES("Doug Romero", 036256, "YyJ45wi2", 01012009);

INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Frankie Leonard", 42, "M", 77423, NULL, 0, 1, 630, 1130, 1230, 1300, 1800, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Damon Garner", 2, "M", 124, 195, 0, 1, 730, 1200, 1230, 1300, 1845, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Manuel Hoffman", 6, "M", 125231, NULL, 0, 1, 730, 1200, 1230, 1300, 1845, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Vernon Jordan", 23, "M", 1345431, 100000, 0, 0, 700, 1130, 1230, 1300, 1800, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Jose James", 14, "M", 1235156, 90000, 0, 0, 730, 1200, 1230, 1300, 1845, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Russell Barnes", 2, "M", 985, 150, 0, 1, 730, 1200, 1230, 1300, 1845, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Levi Chapman", 66, "M", 904921, NULL, 0, 0, 630, 1130, 1230, 1300, 1800, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Alejandro Fox", 1, "M", 01857, 150, 0, 0, 730, 1200, 1230, 1300, 1845, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Austin Strickland", 12, "M", 65615, 450, 0, 1, 730, 1200, 1230, 1300, 1845, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Henry Caldwell", 85, "M", 0180111, NULL, 1, 0, 630, 1100, 1230, NULL, 1700, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Kirk Henry", 54, "M", 8567412, NULL, 0, 0, 630, 1130, 1300, 1400, 1800, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Taylor Berry", 16, "M", 010945, NULL, 0, 1, 700, 1130, 1300, 1400, 1800, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("George Carr", 17, "M", 74276, 1400, 0, 1, 700, 1130, 1300, 1400, 1800, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Carl Phillips", 54, "M", 72568751, 500000, 0, 0, 630, 1130, 1300, 1400, 1800, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Van Diaz", 12, "M", 089515, 1500, 0, 1, 730, 1200, 1300, 1400, 1845, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Angelo Bailey", 6, "M", 915780, 1000, 0, 0, 730, 1200, 1300, 1400, 1845, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Darren Miller", 54, "M", 957895, 5600, 0, 1, 630, 1130, 1300, 1400, 1800, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Mathew Murdock", 352, "M", 90905810, NULL, 1, 0, 630, 1100, 1300, NULL, 1700, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Homer Gray", 4, "M", 511980, 500, 0, 0, 730, 1200, 1300, 1400, 1845, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Jason Castro", 44, "M", 00998977, 25000, 0, 1, 630, 1130, 1400, 1500, 1800, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Greg Wheeler", 98, "M", 65667180, NULL, 1, 0, 630, 1100, 1400, NULL, 1700, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Ricky Parsons", 83, "M", 0134, NULL, 1, 0, 630, 1100, 1400, NULL, 1700, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Elmer Hayes", 75, "M", 8766, NULL, 1, 0, 630, 1100, 1400, NULL, 1700, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Abraham Griffith", 1, "M", 89144, NULL, 0, 0, 730, 1200, 1400, 1500, 1845, 2000);
INSERT INTO Inmate(name, sentence_length, gender, prison_id, bail, death_row_eligible, parole_eligibility, wake_up, brunch_time, free_time, yard_time, dinner_time, sleep_time) VALUES("Marty Fernandez", 14, "M", 87789015, 2500, 0, 1, 730, 1130, 1400, 1500, 1800, 2000);

INSERT INTO Block VALUES("A", 1);
INSERT INTO Block VALUES("B", 2);
INSERT INTO Block VALUES("C", 3);

INSERT INTO Guard VALUES(319866, 25000);
INSERT INTO Guard VALUES(474752, 25000);
INSERT INTO Guard VALUES(456687, 25000);
INSERT INTO Guard VALUES(002252, 25000);
INSERT INTO Guard VALUES(203384, 27000);
INSERT INTO Guard VALUES(653828, 27000);
INSERT INTO Guard VALUES(909698, 27000);
INSERT INTO Guard VALUES(885600, 22000);
INSERT INTO Guard VALUES(816800, 30000);
INSERT INTO Guard VALUES(479491, 30000);
INSERT INTO Guard VALUES(634360, 25000);
INSERT INTO Guard VALUES(126432, 28000);
INSERT INTO Guard VALUES(994823, 28000);
INSERT INTO Guard VALUES(685385, 50000);
INSERT INTO Guard VALUES(036256, 60000);


INSERT INTO Cook VALUES(792332, 20000);
INSERT INTO Cook VALUES(030107, 20000);
INSERT INTO Cook VALUES(016094, 30000);

INSERT INTO Cell VALUES(1, 1, "C");
INSERT INTO Cell VALUES(1, 2, "C");
INSERT INTO Cell VALUES(1, 3, "C");
INSERT INTO Cell VALUES(1, 4, "C");
INSERT INTO Cell VALUES(1, 5, "C");
INSERT INTO Cell VALUES(2, 1, "B");
INSERT INTO Cell VALUES(2, 2, "B");
INSERT INTO Cell VALUES(2, 3, "B");
INSERT INTO Cell VALUES(2, 4, "B");
INSERT INTO Cell VALUES(2, 5, "B");
INSERT INTO Cell VALUES(2, 6, "B");
INSERT INTO Cell VALUES(2, 1, "A");
INSERT INTO Cell VALUES(2, 2, "A");
INSERT INTO Cell VALUES(2, 3, "A");
INSERT INTO Cell VALUES(2, 4, "A");
INSERT INTO Cell VALUES(2, 5, "A");
INSERT INTO Cell VALUES(2, 6, "A");

INSERT INTO Manages VALUES("Wilson Fisk", 792332);
INSERT INTO Manages VALUES("Wilson Fisk", 030107);
INSERT INTO Manages VALUES("Wilson Fisk", 016094);
INSERT INTO Manages VALUES("Wilson Fisk", 319866);
INSERT INTO Manages VALUES("Wilson Fisk", 474752);
INSERT INTO Manages VALUES("Wilson Fisk", 456687);
INSERT INTO Manages VALUES("Wilson Fisk", 002252);
INSERT INTO Manages VALUES("Wilson Fisk", 203384);
INSERT INTO Manages VALUES("Wilson Fisk", 653828);
INSERT INTO Manages VALUES("Wilson Fisk", 909698);
INSERT INTO Manages VALUES("Wilson Fisk", 885600);
INSERT INTO Manages VALUES("Wilson Fisk", 816800);
INSERT INTO Manages VALUES("Wilson Fisk", 479491);
INSERT INTO Manages VALUES("Wilson Fisk", 634360);
INSERT INTO Manages VALUES("Wilson Fisk", 126432);
INSERT INTO Manages VALUES("Wilson Fisk", 994823);
INSERT INTO Manages VALUES("Wilson Fisk", 685385);
INSERT INTO Manages VALUES("Wilson Fisk", 036256);

INSERT INTO Employee_Phone VALUES(792332, 1111111119);
INSERT INTO Employee_Phone VALUES(030107, 9476819898);
INSERT INTO Employee_Phone VALUES(016094, 1949185723);


INSERT INTO Guard_Shift VALUES("A", 319866);
INSERT INTO Guard_Shift VALUES("A", 474752);
INSERT INTO Guard_Shift VALUES("A", 456687);
INSERT INTO Guard_Shift VALUES("A", 002252);
INSERT INTO Guard_Shift VALUES("A", 203384);
INSERT INTO Guard_Shift VALUES("B", 653828);
INSERT INTO Guard_Shift VALUES("B", 909698);
INSERT INTO Guard_Shift VALUES("B", 885600);
INSERT INTO Guard_Shift VALUES("B", 816800);
INSERT INTO Guard_Shift VALUES("B", 479491);
INSERT INTO Guard_Shift VALUES("C", 634360);
INSERT INTO Guard_Shift VALUES("C", 126432);
INSERT INTO Guard_Shift VALUES("C", 994823);
INSERT INTO Guard_Shift VALUES("C", 685385);
INSERT INTO Guard_Shift VALUES("C", 036256);


INSERT INTO Cell_Block VALUES(1, "C");
INSERT INTO Cell_Block VALUES(2, "C");
INSERT INTO Cell_Block VALUES(3, "C");
INSERT INTO Cell_Block VALUES(4, "C");
INSERT INTO Cell_Block VALUES(5, "C");
INSERT INTO Cell_Block VALUES(1, "B");
INSERT INTO Cell_Block VALUES(2, "B");
INSERT INTO Cell_Block VALUES(3, "B");
INSERT INTO Cell_Block VALUES(4, "B");
INSERT INTO Cell_Block VALUES(5, "B");
INSERT INTO Cell_Block VALUES(6, "B");
INSERT INTO Cell_Block VALUES(1, "A");
INSERT INTO Cell_Block VALUES(2, "A");
INSERT INTO Cell_Block VALUES(3, "A");
INSERT INTO Cell_Block VALUES(4, "A");
INSERT INTO Cell_Block VALUES(5, "A");
INSERT INTO Cell_Block VALUES(6, "A");

INSERT INTO Crimes_Committed VALUES("Framed", 77423);
INSERT INTO Crimes_Committed VALUES("Murder", 124);
INSERT INTO Crimes_Committed VALUES("B&E", 124);
INSERT INTO Crimes_Committed VALUES("Racketeering", 125231);
INSERT INTO Crimes_Committed VALUES("Possession with intent to distribute", 125231);
INSERT INTO Crimes_Committed VALUES("Murder", 1345431);
INSERT INTO Crimes_Committed VALUES("Murder", 1235156);
INSERT INTO Crimes_Committed VALUES("B&E", 985);
INSERT INTO Crimes_Committed VALUES("Assault with a deadly weapon", 985);
INSERT INTO Crimes_Committed VALUES("Jaywalking", 904921);
INSERT INTO Crimes_Committed VALUES("Murder", 01857);
INSERT INTO Crimes_Committed VALUES("Murder", 65615);
INSERT INTO Crimes_Committed VALUES("Filling water cup with soda", 0180111);
INSERT INTO Crimes_Committed VALUES("Fraud", 8567412);
INSERT INTO Crimes_Committed VALUES("Forgery", 8567412);
INSERT INTO Crimes_Committed VALUES("Murder", 010945);
INSERT INTO Crimes_Committed VALUES("Murder", 74276);
INSERT INTO Crimes_Committed VALUES("Arson", 72568751);
INSERT INTO Crimes_Committed VALUES("Disturbing the peace", 72568751);
INSERT INTO Crimes_Committed VALUES("Murder", 089515);
INSERT INTO Crimes_Committed VALUES("Kidnapping", 915780);
INSERT INTO Crimes_Committed VALUES("Perjury", 957895);
INSERT INTO Crimes_Committed VALUES("Indecent Exposure", 90905810);
INSERT INTO Crimes_Committed VALUES("Piracy of Winrar", 90905810);
INSERT INTO Crimes_Committed VALUES("Murder", 511980);
INSERT INTO Crimes_Committed VALUES("Bribery", 00998977);
INSERT INTO Crimes_Committed VALUES("Extortion", 65667180);
INSERT INTO Crimes_Committed VALUES("Aiding & Abetting", 0134);
INSERT INTO Crimes_Committed VALUES("Framed", 8766);
INSERT INTO Crimes_Committed VALUES("Embezzlement", 8766);
INSERT INTO Crimes_Committed VALUES("Harassment", 89144);
INSERT INTO Crimes_Committed VALUES("Insurance Fraud", 87789015);


INSERT INTO Lives VALUES(1, 8766, "C");
INSERT INTO Lives VALUES(2, 0134, "C");
INSERT INTO Lives VALUES(3, 65667180, "C");
INSERT INTO Lives VALUES(4, 90905810, "C");
INSERT INTO Lives VALUES(5, 0180111, "C");
INSERT INTO Lives VALUES(1, 77423, "B");
INSERT INTO Lives VALUES(1, 904921, "B");
INSERT INTO Lives VALUES(2, 8567412, "B");
INSERT INTO Lives VALUES(2, 72568751, "B");
INSERT INTO Lives VALUES(3, 957895, "B");
INSERT INTO Lives VALUES(3, 00998977, "B");
INSERT INTO Lives VALUES(4, 1345431, "B");
INSERT INTO Lives VALUES(4, 87789015, "B");
INSERT INTO Lives VALUES(5, 74276, "B");
INSERT INTO Lives VALUES(5, 010945, "B");
INSERT INTO Lives VALUES(1, 89144, "A");
INSERT INTO Lives VALUES(1, 511980, "A");
INSERT INTO Lives VALUES(2, 915780, "A");
INSERT INTO Lives VALUES(2, 089515, "A");
INSERT INTO Lives VALUES(3, 65615, "A");
INSERT INTO Lives VALUES(3, 01857, "A");
INSERT INTO Lives VALUES(4, 985, "A");
INSERT INTO Lives VALUES(4, 1235156, "A");
INSERT INTO Lives VALUES(5, 125231, "A");
INSERT INTO Lives VALUES(5, 124, "A");

COMMIT;
PRAGMA foreign_keys=on;
