-- ukb.baseline definition

CREATE TABLE `baseline` (
  `eid` int(11) DEFAULT NULL,
  `field` varchar(10) DEFAULT NULL,
  `value` varbinary(512) DEFAULT NULL,
  KEY `p` (`eid`,`field`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


-- ukb.gp_clinical definition

CREATE TABLE `gp_clinical` (
  `eid` int(11) DEFAULT NULL,
  `data_provider` int(1) DEFAULT NULL,
  `event_dt` date DEFAULT NULL,
  `read_2` varchar(256) DEFAULT NULL,
  `read_3` varchar(256) DEFAULT NULL,
  `value1` varchar(256) DEFAULT NULL,
  `value2` varchar(256) DEFAULT NULL,
  `value3` varchar(256) DEFAULT NULL,
  `readcode` varchar(6) DEFAULT NULL,
  KEY `p` (`eid`,`read_2`,`read_3`),
  KEY `r` (`readcode`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


-- ukb.gp_registrations definition

CREATE TABLE `gp_registrations` (
  `eid` int(11) DEFAULT NULL,
  `data_provider` int(1) DEFAULT NULL,
  `reg_date` date DEFAULT NULL,
  `deduct_date` date DEFAULT NULL,
  KEY `p` (`eid`,`reg_date`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


-- ukb.gp_scripts definition

CREATE TABLE `gp_scripts` (
  `eid` int(11) DEFAULT NULL,
  `data_provider` int(1) DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `read_2` varchar(256) DEFAULT NULL,
  `bnf_code` varchar(256) DEFAULT NULL,
  `dmd_code` varchar(256) DEFAULT NULL,
  `drug_name` varchar(256) DEFAULT NULL,
  `quantity` varchar(256) DEFAULT NULL,
  KEY `p` (`eid`,`read_2`,`bnf_code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


-- ukb.hesin definition

CREATE TABLE `hesin` (
  `eid` int(11) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `admidate` date DEFAULT NULL,
  `cause_icd10` varchar(5) DEFAULT NULL,
  `cause_icd10_nb` varchar(5) DEFAULT NULL,
  `diag_icd10` varchar(5) DEFAULT NULL,
  `diag_icd10_nb` varchar(5) DEFAULT NULL,
  `diag_icd9` varchar(5) DEFAULT NULL,
  `diag_icd9_nb` varchar(5) DEFAULT NULL,
  `disdate` date DEFAULT NULL,
  `epiend` date DEFAULT NULL,
  `epistart` date DEFAULT NULL,
  `opdate` date DEFAULT NULL,
  `oper4` varchar(5) DEFAULT NULL,
  KEY `p` (`eid`,`record_id`,`diag_icd10`),
  KEY `p2` (`eid`,`diag_icd10`,`diag_icd9`),
  KEY `r1` (`record_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


-- ukb.hesin_diag10 definition

CREATE TABLE `hesin_diag10` (
  `eid` int(11) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `arr_index` int(11) DEFAULT NULL,
  `diag_icd10` varchar(5) DEFAULT NULL,
  `diag_icd10_nb` int(11) DEFAULT NULL,
  KEY `p` (`eid`,`record_id`,`diag_icd10`),
  KEY `r1` (`record_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


-- ukb.hesin_oper definition

CREATE TABLE `hesin_oper` (
  `eid` int(11) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `arr_index` int(11) DEFAULT NULL,
  `opdate` date DEFAULT NULL,
  `oper4` varchar(5) DEFAULT NULL,
  KEY `p` (`eid`,`record_id`,`oper4`),
  KEY `r1` (`record_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


-- ukb.lookup_icd10 definition

CREATE TABLE `lookup_icd10` (
  `coding` varchar(50) DEFAULT NULL,
  `meaning` varchar(250) DEFAULT NULL,
  `node_id` int(5) DEFAULT NULL,
  `parent_id` int(5) DEFAULT NULL,
  `selectable` char(1) DEFAULT NULL,
  KEY `i` (`coding`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


-- ukb.lookup_icd9 definition

CREATE TABLE `lookup_icd9` (
  `coding` varchar(50) DEFAULT NULL,
  `meaning` varchar(250) DEFAULT NULL,
  `node_id` int(5) DEFAULT NULL,
  `parent_id` int(5) DEFAULT NULL,
  `selectable` char(1) DEFAULT NULL,
  KEY `i` (`coding`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


-- ukb.lookup_opcs definition

CREATE TABLE `lookup_opcs` (
  `coding` varchar(50) DEFAULT NULL,
  `meaning` varchar(250) DEFAULT NULL,
  `node_id` int(5) DEFAULT NULL,
  `parent_id` int(5) DEFAULT NULL,
  `selectable` char(1) DEFAULT NULL,
  KEY `i` (`coding`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;