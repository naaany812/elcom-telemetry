drop table measures;

create table data_rssi
(
	id int,
	order_num     integer,
    uid           text,
    id_train      integer,
    car_number    integer,
    receiver_code integer,
    device_type   varchar(5) default '00'::text,
    command_type  integer,
    time          timestamp,
	rssi int,
	rssi_reverse int,
	received_count int,
	total_count int,
    time_received timestamp
);
create unique index data_rssi_id_uindex
	on data_rssi (id);


create table data_geo
(
	id int,
	order_num     integer,
    uid           text,
    id_train      integer,
    car_number    integer,
    receiver_code integer,
    device_type   varchar(5) default '00'::text,
    command_type  integer,
    time          timestamp,
	latitude text,
	longitude text,
	alt float,
	speed float,
    course float,
    time_received timestamp
);
create unique index data_geo_id_uindex
	on data_geo (id);

