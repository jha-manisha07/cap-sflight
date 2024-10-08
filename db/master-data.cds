using {
    Currency,
    Country,
    custom.managed,
    sap
} from './common';

namespace sap.fe.cap.travel;

@cds.autoexpose  @readonly
aspect MasterData {}


entity Airline : MasterData {

    key AirlineID     : String(3);
        name          : String(40);
        CurrencyCode  : Currency;
        AirlinePicURL : String @UI: {IsImageURL: true}

}

entity Airport : MasterData {

    key AirportID   : String(3);
        Name        : String(40);
        City        : String(40);
        CountryCode : Country;
}

entity Supplement : managed, MasterData {

    key SupplementID : String(10);
        Price        : Decimal(10, 3);
        Type         : Association to SupplementType;
        Description  : localized String(1024);
        CountryCode  : Currency;
}

entity SupplementType : sap.common.CodeList {

    key code : String(2) enum {

            Beverage = 'BV';
            Meal     = 'ML';
            Luggage  = 'LU';
            Extra    = 'EX';
        }

}

entity Flight : MasterData {

    key AirlineID     : String(3);
    key FlightDate    : Date;
    key ConnectionID  : String(4);
        Price         : Decimal(16, 3);
        CountryCode   : Currency;
        planeType     : String(10);
        MiximunSeat   : Integer;
        OccupiedSeat  : Integer;

        to_Airline    : Association to Airline
                            on to_Airline.AirlineID = AirlineID;
        to_Connection : Association to FlightConnection
                            on  to_Connection.AirlineID    = AirlineID
                            and to_Connection.ConnectionID = ConnectionID;

}

entity FlightConnection : MasterData {
    key ConnectionID       : String(4);
    key AirlineID          : String(3);
        DepartureAirport   : Association to Airport;
        DestinationAirport : Association to Airport;
        DepartureTime      : Time;
        ArrivalTime        : Time;
        Distance           : Integer;
        DistanceUnit       : String(3);

        to_Airline         : Association to Airline
                                 on to_Airline.AirlineID = AirlineID;
}

entity Passenger : managed, MasterData {
    key CustomerID   : String(6);
        FirstName    : String(40);
        LastName     : String(40);
        Title        : String(10);
        Street       : String(60);
        PostalCode   : String(10);
        City         : String(40);
        CountryCode  : Country;
        PhoneNumber  : String(30);
        EMailAddress : String(256);
};

entity TravelAgency : MasterData {
    key AgencyID     : String(6);
        Name         : String(80);
        Street       : String(60);
        PostalCode   : String(10);
        City         : String(40);
        CountryCode  : Country;
        PhoneNumber  : String(30);
        EMailAddress : String(256);
        WebAddress   : String(256);
};
