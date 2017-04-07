fh = open("insertLocations.sql", "w")

# Ballard North
floor_num = 1
prefix = "BN 1"
while (floor_num <= 4):
	room_num = 0
	while (room_num <= 19):
		location_name = prefix + str(floor_num) + str(room_num).zfill(2)
		fh.write("INSERT INTO location (location_id_pk, location_name, location_descr) values (SEQ_LOCATION.NEXTVAL, '" + location_name + "', "  + "NULL" + ");\n")
		room_num += 1
	floor_num += 1


# Ballard South
floor_num = 1
prefix = "BS 1"
while (floor_num <= 4):
	room_num = 50
	while (room_num <= 69):
		location_name = prefix + str(floor_num) + str(room_num).zfill(2)
		fh.write("INSERT INTO location (location_id_pk, location_name, location_descr) values (SEQ_LOCATION.NEXTVAL, '" + location_name + "', "  + "NULL" + ");\n")
		room_num += 1
	floor_num += 1


# Cobberly North
floor_num = 1
prefix = "CN 2"
while (floor_num <= 4):
	room_num = 0
	while (room_num <= 19):
		location_name = prefix + str(floor_num) + str(room_num).zfill(2)
		fh.write("INSERT INTO location (location_id_pk, location_name, location_descr) values (SEQ_LOCATION.NEXTVAL, '" + location_name + "', "  + "NULL" + ");\n")
		room_num += 1
	floor_num += 1


# Cobberly South
floor_num = 1
prefix = "CS 2"
while (floor_num <= 4):
	room_num = 50
	while (room_num <= 69):
		location_name = prefix + str(floor_num) + str(room_num).zfill(2)
		fh.write("INSERT INTO location (location_id_pk, location_name, location_descr) values (SEQ_LOCATION.NEXTVAL, '" + location_name + "', "  + "NULL" + ");\n")
		room_num += 1
	floor_num += 1


# Young Tower
floor_num = 1
prefix = "YT 6"
while (floor_num <= 9):
	room_num = 0
	while (room_num <= 29):
		location_name = prefix + str(floor_num) + str(room_num).zfill(2)
		fh.write("INSERT INTO location (location_id_pk, location_name, location_descr) values (SEQ_LOCATION.NEXTVAL, '" + location_name + "', "  + "NULL" + ");\n")
		room_num += 1
	floor_num += 1


# Bradley Tower
floor_num = 1
prefix = "BT 3"
while (floor_num <= 9):
	room_num = 0
	while (room_num <= 29):
		location_name = prefix + str(floor_num) + str(room_num).zfill(2)
		fh.write("INSERT INTO location (location_id_pk, location_name, location_descr) values (SEQ_LOCATION.NEXTVAL, '" + location_name + "', "  + "NULL" + ");\n")
		room_num += 1
	floor_num += 1


# Griffith Tower
floor_num = 1
prefix = "GT 5"
while (floor_num <= 9):
	room_num = 0
	while (room_num <= 29):
		location_name = prefix + str(floor_num) + str(room_num).zfill(2)
		fh.write("INSERT INTO location (location_id_pk, location_name, location_descr) values (SEQ_LOCATION.NEXTVAL, '" + location_name + "', "  + "NULL" + ");\n")
		room_num += 1
	floor_num += 1


# Dixon Tower
floor_num = 1
prefix = "DT 4"
while (floor_num <= 9):
	room_num = 0
	while (room_num <= 29):
		location_name = prefix + str(floor_num) + str(room_num).zfill(2)
		fh.write("INSERT INTO location (location_id_pk, location_name, location_descr) values (SEQ_LOCATION.NEXTVAL, '" + location_name + "', "  + "NULL" + ");\n")
		room_num += 1
	floor_num += 1
