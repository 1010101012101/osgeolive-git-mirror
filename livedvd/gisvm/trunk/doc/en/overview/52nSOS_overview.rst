﻿:Author: Eike Hinderk Jürrens (e.h.juerrens@52north.org), Daniel Nüst (d.nuest@52north.org), Simon Jirka (s.jirka@52north.org)
:Reviewer: Cameron Shorter, LISAsoft
:Reviewer: Frank Gasdorf
:Version: osgeo-live8.0
:License: Creative Commons Attribution 3.0 Unported (CC BY 3.0)

.. image:: ../../images/project_logos/logo_52North_160.png
  :scale: 100 %
  :alt: project logo
  :align: right
  :target: http://52north.org/sos


52°North SOS
===============================================================================

Web Service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The 52°North :doc:`Sensor Observation Service (SOS) <../standards/sos_overview>` 
supports the interoperable provision of live and archived sensor observation 
data. A sensor could be a water level meter in a stream, a weather station, or 
an air quality monitoring station.
 
.. image:: ../../images/screenshots/1024x768/52n_sos_test_client_v4_0_0_GetCapabilities_json.png
  :scale: 60 %
  :alt: screenshot of 52°North SOS test client version 1.0.0
  :align: right

Features
-------------------------------------------------------------------------------

* Implements the SOS 1.0.0 and 2.0.0 standards.

* A browser based client provides means for administration and configuration of
  the service instance. In addition, test queries for all supported operations
  are provided.


OGC SOS 2.0.0
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Operations of “SOS Core Profiles“**:

* GetCapabilities, for requesting a self-description of the service.
* DescribeSensor, for requesting information about the sensor.

**Operations of “SOS Enhanced Profiles”**:

* GetFeatureOfInterest, for requesting features (e.g. sensor/measurement 
  locations).
* GetObservationById, for requesting a single observation.

**Operation of “SOS Result Handling Profiles”**:

* InsertResultTemplate, for inserting a result template describing the 
  structure and metadata of observations generated by a sensor.
* InsertResult, for inserting results relying on a previously registered result
  template.
* GetResultTemplate, for requesting a template of the result structure that 
  will be returned by a GetResult request.
* GetResult, for requesting sensor data.

**Operations of “SOS Transactional Profiles”**:

* InsertSensor, for inserting metadata of new sensors.
* InsertObservation, for inserting new observations for registered sensors.
* UpdateSensorDescription, for updating the description of an already inserted 
  sensor.
* DeleteSensor, for deleting a sensor/procedure and all related offerings 
  and observations.

**Operation “Data Availability”**:

* GetDataAvailability, for requesting the data availability for certain 
  configurations.

**Operation “Delete Observation”**:

* DeleteObservation, for deleting an observation.

Within these requests the following filter operators are possible where 
applicable:

* Spatial filter: BBOX, using a bounding box.
* Temporal filter: During, with time period.
* Temporal filter: TEquals, with time instant.

OGC SOS 1.0.0
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
**Core operations**:

* GetCapabilities, for requesting a self-description of the service.
* GetObservation, for requesting Observations & Measurements (O&M).
* DescribeSensor, for requesting information about the sensor.

**Transactional operations**:

* RegisterSensor, for inserting metadata of new sensors.
* InsertObservation, for inserting new observations for registered sensors.

**Additional operations**:

* GetResult, for requesting sensor data.
* GetObservationById, for requesting a single observation.
* GetFeatureOfInterest, for requesting the features (e.g. sensor/measurement 
  locations) hosted by this SOS instance.
* GetFeatureOfInterestTime, for determining the temporal availability of sensor data.

Related Standards
--------------------------------------------------------------------------------

* :doc:`Sensor Observation Service (SOS) <../standards/sos_overview>`
* :doc:`Geography Markup Language (GML) <../standards/gml_overview>`
* :doc:`Sensor Model Language (SensorML) <../standards/sensorml_overview>`

Details
--------------------------------------------------------------------------------

**Website:** http://52north.org/sos

**Licence:** GNU General Public License (GPL) version 2

**Software Version:** SOS |version-52nSOS|

**Supported Platforms:** Windows, Linux, Mac

**API Interfaces:** Java

**Commercial Support:** http://52north.org/

**Community Support:** http://sensorweb.forum.52north.org/

**Community Website:** http://52north.org/communities/sensorweb/

**Other 52°North projects:** :doc:`WPS <./52nWPS_overview>`

Quickstart
--------------------------------------------------------------------------------

* :doc:`Quickstart documentation <../quickstart/52nSOS_quickstart>`

