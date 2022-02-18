USE [master]
USE InsuranceCompany
GO

INSERT INTO Philia (Name, Address, Phone) VALUES
('Heller-Watsica', '652 Homewood Lane', '221-740-4153'),
('Beatty-Lebsack', '7 Forster Park', '244-435-6551'),
('Aufderhar-Johnston', '3 Lighthouse Bay Park', '515-313-0095'),
('Turcotte-MacGyver', '591 Kinsman Place', '448-446-6055'),
('O''Keefe-Rippin', '08 Butternut Place', '597-687-4105'),
('Gutkowski LLC', '1 Leroy Street', '585-446-8599'),
('Swift Inc', '770 Cody Court', '247-177-7708'),
('Heathcote, Dare and Lebsack', '59 Mcbride Plaza', '596-517-3872'),
('Cartwright-Krajcik', '06 Daystar Circle', '562-164-3159'),
('Bergnaum, Wuckert and Lesch', '5 Grim Drive', '713-758-0091'),
('Koss, Rolfson and Sanford', '0 Rutledge Plaza', '355-310-0122'),
('Kunde LLC', '586 Westerfield Way', '879-817-3116'),
('Hammes LLC', '88 Dennis Point', '994-197-1065'),
('Zulauf Inc', '34902 Lakeland Plaza', '131-551-3052'),
('Littel, Langosh and Thompson', '5497 Troy Pass', '979-244-7875'),
('Pfannerstill Group', '9689 Darwin Place', '903-701-0028'),
('Schamberger, Balistreri and Tremblay', '8981 Dexter Road', '931-962-3808'),
('Glover-Johnston', '48315 Longview Avenue', '129-176-4464'),
('Kautzer, Schoen and Welch', '97075 Namekagon Road', '661-445-6245'),
('Nikolaus Inc', '499 Maywood Avenue', '473-335-9809'),
('O''Connell, Grimes and Carroll', '6888 Rigney Circle', '223-616-4381'),
('Torp, Towne and Bauch', '53 Sloan Crossing', '215-970-4124'),
('Klocko and Sons', '97 Fulton Circle', '691-262-6120'),
('Reinger, Bartell and Marks', '3878 Loftsgordon Point', '203-572-2686'),
('Beatty-Murphy', '595 Hoffman Lane', '643-728-8839'),
('Witting and Sons', '8225 Erie Crossing', '960-353-4414'),
('Rowe LLC', '36 Armistice Circle', '532-608-5326'),
('Rolfson, Beahan and Kerluke', '5 Maywood Trail', '202-827-1240'),
('Blick-Rau', '540 Lindbergh Avenue', '866-951-2989'),
('Kshlerin, Pfeffer and Lebsack', '91 Grover Crossing', '371-733-7629');
GO

INSERT INTO Agent (Name, Surname, Patronymic, Address, Phone, FkPhiliaID) VALUES 
('Shayne', 'Swatheridge', 'Godden', '2694 Amoth Pass', '600-789-2932', 1),
('Haley', 'Dewey', 'Bart', '1 Memorial Terrace', '150-399-3734', 2),
('Gonzales', 'Andrichuk', 'Seignior', '484 Vera Crossing', '113-750-5868', 3),
('Marlo', 'Gauvain', 'Klazenga', '84 Blaine Court', '451-255-3350', 4),
('Darcie', 'MacCartair', 'Hurdiss', '6 Moose Crossing', '367-261-4038', 5),
('Silvia', 'Aistrop', 'Kitchiner', '45690 Elgar Point', '885-470-6457', 6),
('Catha', 'Lucchi', 'Clere', '788 Larry Parkway', '907-364-2857', 7),
('Roderigo', 'Yegoshin', 'Townrow', '632 Upham Junction', '966-298-0010', 8),
('Miquela', 'Kidston', 'Chittey', '49 Hallows Alley', '788-162-6250', 9),
('Deny', 'Rounsefull', 'Robottom', '908 Swallow Plaza', '229-300-0271', 10),
('Barbabra', 'Leney', 'Longmore', '868 Sutherland Crossing', '399-448-8552', 11),
('Demetris', 'Duffrie', 'Wheldon', '28 Summit Junction', '490-928-6391', 12),
('Jozef', 'Josselson', 'Delve', '106 Anhalt Center', '347-421-1300', 13),
('Ilaire', 'Martschik', 'Drohane', '93565 Toban Circle', '149-423-8988', 14),
('Stan', 'Lavender', 'Oaten', '29 Coleman Way', '246-922-0772', 15),
('Dame', 'Lapwood', 'Biggs', '58 Old Gate Street', '987-861-0874', 16),
('Richardo', 'Sellack', 'Ygo', '15 Division Point', '691-192-9417', 17),
('Drona', 'Wardall', 'Sparks', '13 Cordelia Point', '138-396-9277', 18),
('Raddy', 'Bungey', 'Rawle', '87 Columbus Plaza', '506-583-2645', 19),
('Cristobal', 'Eskrick', 'Jonke', '096 Gateway Street', '659-571-7475', 20),
('Eyde', 'Buttrick', 'Rathe', '7844 Sachs Plaza', '529-726-5368', 21),
('Cello', 'Huggen', 'Stading', '50480 Everett Junction', '660-519-0512', 22),
('Barney', 'Yellep', 'Mitie', '378 Holy Cross Lane', '821-757-7310', 23),
('Myrtie', 'Odhams', 'Thinn', '2261 Hanson Point', '733-685-0414', 24),
('Noam', 'Buske', 'Cloake', '1937 Kensington Avenue', '997-282-9177', 25),
('Hedi', 'Lorden', 'Bellie', '0570 Bultman Crossing', '622-390-5606', 26),
('Lenna', 'Sear', 'MacNair', '55679 Sachtjen Junction', '299-297-1519', 27),
('Rivalee', 'Huyghe', 'Dashper', '51 Anniversary Place', '636-503-0950', 28),
('Kiah', 'Knight', 'Diggar', '3537 Prairie Rose Place', '391-593-1816', 29),
('Sydney', 'Andrei', 'Trunkfield', '4 Cascade Crossing', '973-253-0065', 30)
GO

INSERT INTO Agent VALUES('Mila', 'Halko', 'Viacheslavivna', 'Nyvky pr.Victory 666', '098-765-4321', 7)
GO

INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-03-16', 32.9, 13.9, 31)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-11-10', 34.59, 5.27, 32)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-01-26', 25.1, 5.67, 33)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-10-09', 29.48, 10.78, 34)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-10-11', 22.63, 13.65, 5)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-10-03', 26.21, 13.61, 6)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-09-18', 35.3, 6.59, 7)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-10-11', 37.42, 14.03, 8)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-11-08', 21.2, 5.39, 9)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-11-06', 22.82, 10.61, 10)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-02-08', 33.0, 14.2, 11)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-01-17', 22.61, 5.25, 12)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-10-07', 25.16, 14.05, 13)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-04-02', 35.54, 7.47, 14)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-06-19', 30.51, 5.49, 15)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-05-30', 36.47, 9.58, 16)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-03-15', 33.73, 7.08, 17)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-07-24', 28.79, 13.63, 18)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-10-22', 38.22, 10.4, 19)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-10-26', 27.26, 6.07, 20)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-03-09', 29.54, 12.21, 21)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-02-27', 21.47, 6.9, 22)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-07-14', 32.14, 10.15, 23)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-03-27', 27.3, 10.64, 24)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-07-18', 28.56, 11.53, 25)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-12-21', 25.45, 8.21, 26)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-09-03', 33.79, 10.45, 27)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-02-13', 32.03, 11.88, 28)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-09-19', 32.06, 14.35, 29)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2021-03-13', 27.94, 12.15, 30)
GO

INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2022-01-13', 20.94, 1.15, 30)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2022-01-15', 22.94, 11.15, 30)
INSERT INTO InsContract (RegistrationDate, InsAmount, TariffRate, FkAgentID) VALUES ('2022-01-01', 10.94, 9.35, 20)
GO

INSERT INTO InsType (Item, Risk, FkInsContractID) VALUES 
('Optima', 'Customer-focused solution-oriented benchmark', 1),
('GTI', 'Up-sized content-based array', 2),
('Avalon', 'Compatible composite benchmark', 3),
('M', 'Object-based homogeneous benchmark', 4),
('Paseo', 'Inverse zero administration toolset', 5),
('VS Commodore', 'Compatible static task-force', 6),
('Navigator', 'Diverse empowering customer loyalty', 7),
('Cooper', 'Customer-focused motivating service-desk', 8),
('57', 'Upgradable motivating archive', 9),
('Wrangler', 'Extended full-range data-warehouse', 10),
('Miata MX-5', 'Cross-group clear-thinking framework', 11),
('Suburban 2500', 'Grass-roots bandwidth-monitored encryption', 12),
('Altima', 'Centralized systematic flexibility', 13),
('Corolla', 'Profit-focused content-based portal', 14),
('LeSabre', 'Front-line discrete database', 15),
('LaCrosse', 'Synergized transitional secured line', 16),
('Express 3500', 'Horizontal hybrid implementation', 17),
('9-5', 'Open-source radical Graphic Interface', 18),
('Freelander', 'Programmable leading edge time-frame', 19),
('300', 'Realigned user-facing algorithm', 20),
('DBS', 'Cross-platform multi-state focus group', 21),
('EV1', 'Devolved web-enabled leverage', 22),
('Regal', 'Pre-emptive cohesive alliance', 23),
('C8 Double 12 S', 'Proactive didactic circuit', 24),
('Durango', 'Persistent bifurcated complexity', 25),
('7 Series', 'Robust multi-tasking capacity', 26),
('A6', 'Right-sized directional moderator', 27),
('Touareg 2', 'Team-oriented well-modulated website', 28),
('Frontier', 'Exclusive high-level emulation', 29),
('Ram 2500', 'Vision-oriented uniform pricing structure', 30)
GO

insert into InsType(Item, Risk, FkInsContractID) values
('Car', 'Inverse zero administration toolset', 31),
('House st.Victory', 'Inverse zero administration toolset', 32),
('Speakers', 'Inverse zero administration toolset', 33)

 SELECT * FROM Philia
 SELECT * FROM Agent
 SELECT * FROM InsType
 SELECT * FROM InsContract
 SELECT * FROM Salary
 GO

 
