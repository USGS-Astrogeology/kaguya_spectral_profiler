CREATE TABLE filemetadata (
  file_id SERIAL primary key,
  filepath VARCHAR (256),
  product_id VARCHAR (128),
  keywords JSON
);

CREATE TABLE filelookups (
  file_id INTEGER FOREIGN KEY REFERENCES filemetadata (file_id),
  observation_id SMALLINT,
  incidence DOUBLE PRECISION,
  emission DOUBLE PRECISION,
  PRIMARY KEY (file_id, observation_id)
);

-- SRID 30100 is for the Moon 
SELECT AddGeometryColumn ('my_schema','filelookups','location',30100,'POINT',2, false);

CREATE TABLE datatype (
  type_id SERIAL PRIMARY KEY,
  type VARCHAR (16)
);

CREATE TABLE spectra (
  spectra_id BIGSERIAL PRIMARY KEY,
  file_id INTEGER FOREIGN KEY REFERENCES filemetadata (file_id),
  observation_id SMALLINT FOREIGN KEY REFERENCES filelookups (observation_id),
  type_id INTEGER FOREIGN KEY REFERENCES datatype (type_id),
  spectra DOUBLE PRECISION[]
);
