create database participant;
use participant;
CREATE TABLE accounts (
  account_id varchar(20) NOT NULL PRIMARY KEY,
  study_id varchar(20) NOT NULL,
  data_id varchar(20) NOT NULL,
  email_address varchar(50) NOT NULL,
  login_id varchar(50) NOT NULL,
  seed varchar(20),
  password_hash varchar(100),
  is_account_active char(1) NOT NULL,
  account_type char(1) NOT NULL,
  created_dttm datetime NOT NULL,
  registered_dttm datetime,
  upd_dttm datetime NOT NULL,
  upd_by varchar(50) NOT NULL,
  INDEX(login_id)
);

CREATE TABLE tokens (
  account_id varchar(20) NOT NULL,
  registration_token varchar(50) NOT NULL,
  token_dttm datetime NOT NULL,
  is_token_active char(1) NOT NULL,
  PRIMARY KEY(registration_token, account_id, is_token_active, token_dttm),
  INDEX(account_id)
);

CREATE TABLE participant_activity (
  account_id varchar(20) NOT NULL,
  registration_attempts int4 NOT NULL,
  login_attempts int4 NOT NULL,
  upd_dttm datetime NOT NULL,
  upd_by varchar(50) NOT NULL,
  PRIMARY KEY (account_id, registration_attempts, login_attempts, upd_dttm)
);

CREATE TABLE user_audit (
  user_id varchar(50) NOT NULL,
  account_id varchar(20) NOT NULL,
  action_dttm datetime NOT NULL,
  action varchar(100) NOT NULL,
  PRIMARY KEY(user_id, account_id, action_dttm, action),
  INDEX(account_id)
);

CREATE TABLE participant_audit (
  account_id varchar(20) NOT NULL,
  action_dttm datetime NOT NULL,
  action varchar(100) NOT NULL,
  PRIMARY KEY(account_id, action, action_dttm)
);

DELETE FROM accounts WHERE account_id = 'test_account';
DELETE FROM participant_activity WHERE account_id = 'test_account';
 
INSERT INTO accounts VALUES (
  'test_account',
  'test_account',
  'test_account',
  'rlreamy@umich.edu',
  'rlreamy@umich.edu',
  null,
  null,
  'Y',
  'P',
  NOW(),
  null,
  NOW(),
  'rlreamy'
);
 
INSERT INTO participant_activity VALUES (
  'test_account',
  0,
  0,
  NOW(),
  'rlreamy'
);
 
