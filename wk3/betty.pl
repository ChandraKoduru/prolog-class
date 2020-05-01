
availability1(X):-
    X = [[m,f,g,n],
    [m,g],
    [m,d,g,t,n],
    [f,d],
    [f,d,p,a,n],
    [f,d,p],
    [f,p,n],
    [d,m,p]].

availability2(X):-
    X =[mable-[1,2,3], 
        frieda-[1,4,5,67],
        danielle-[3,4,5,6,8],
        martha-[8],
        % glinda-[1,2,3],
        tammy-[3],
        penny-[5,6,7,8],
        arleen-[5],
        nancy-[1,3,5,7]].


% TODO: need to make the lookup little faster.
% this function loops through every element to find the 
% availability of the customer. Some way of dictionary lookup should make it easy.
get_customer_availability([], _, _) :- !, false.
get_customer_availability([(Customer - Availability)|_], Customer, Availability) :- !, true.
get_customer_availability([_|T], Customer, CustomerAvailability) :- 
  get_customer_availability(T, Customer, CustomerAvailability).

/*
get_customer_availability([_|T], Customer, CustomerAvailability) :-
  ((Name == Customer) -> 
      CustomerAvailability = Availability;
      get_customer_availability(T, Customer, CustomerAvailability)).
    */
/*
 * Entry point function
 */
schedule(Availability, Schedule):-
  HoursOfDay = [1,2,3,4,5,6,7,8],
  maplist(free_slot, HoursOfDay, ScheduleSlots),
  pairs_keys(Availability, AvailableCustomers),
  % Schedule = [1-S1,2-S2,3-S3,4-S4,5-S5,6-S6,7-S7,8-S8],
  schedule_sub(Availability, AvailableCustomers, ScheduleSlots),
  maplist(extract_name, ScheduleSlots, Schedule).

/*
 * Supporting function 
 */

% makes empty pair of hour and a Variable to hold customer name
free_slot(H, H-_).

% extracting a name from a pair
extract_name(_-N, N).

% more customers than available slots..hence failing
schedule_sub(_, [_|_], []) :- fail.

% No customers to be scheduled...hence done.
schedule_sub(_, [], _).

schedule_sub(Availability, [CurCustomer|RestOfCustomers], AvailableSchedule):-
  select(Hour-Slot, AvailableSchedule, RestOfSchedule),
  is_customer_available(Availability, CurCustomer, Hour),
  Slot = CurCustomer,
  schedule_sub(Availability, RestOfCustomers, RestOfSchedule).

is_customer_available(Availability, Customer, HoursOfDay) :-
  get_customer_availability(Availability, Customer, CustomerAvailability),
  member(HoursOfDay, CustomerAvailability).
