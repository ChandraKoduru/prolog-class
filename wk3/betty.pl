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

/*
 * Entry point function
 */
schedule(Availability, Schedule):-
  NoOfWorkingHours = 8,
  findall(V, between(1, NoOfWorkingHours, V), HoursOfDay),
  length(Schedule, NoOfWorkingHours),
  zip(HoursOfDay, Schedule, ScheduleSlots),
  schedule_(Availability, ScheduleSlots).

schedule_([], _). % No customers to be scheduled...nothing to be done.

schedule_([(CurCustomer-CustomerAvailability)|RestOfCustomers], AvailableSchedule):-
  select(Hour-Slot, AvailableSchedule, RestOfSchedule),
  member(Hour, CustomerAvailability),
  Slot = CurCustomer,
  schedule_(RestOfCustomers, RestOfSchedule).

% zip two lists as list of pairs
zip([],[],[]).
zip([H1|T1], [H2|T2], [(H1-H2)|Rest]) :- 
  zip(T1, T2, Rest).

/*
is_customer_available(Availability, Customer, HoursOfDay) :-
  get_customer_availability(Availability, Customer, CustomerAvailability),
  member(HoursOfDay, CustomerAvailability).

% TODO: need to make the lookup little faster.
% this function loops through every element to find the 
% availability of the customer. Some way of dictionary lookup should make it easy.
get_customer_availability([], _, _) :- !, false.

get_customer_availability([(Customer - Availability)|_], Customer, Availability) :- !, true.

get_customer_availability([_|T], Customer, CustomerAvailability) :- 
  get_customer_availability(T, Customer, CustomerAvailability).

get_customer_availability([_|T], Customer, CustomerAvailability) :-
  ((Name == Customer) -> 
      CustomerAvailability = Availability;
      get_customer_availability(T, Customer, CustomerAvailability)).
    */
/*
 *% is_customer_available(Availability, CurCustomer, Hour),
  % pairs_keys(Availability, AvailableCustomers),
  % Schedule = [1-S1,2-S2,3-S3,4-S4,5-S5,6-S6,7-S7,8-S8],
  % maplist(free_slot, HoursOfDay, ScheduleSlots),
  % maplist(extract_name, ScheduleSlots, Schedule).
  */
/*
% makes empty pair of hour and a Variable to hold customer name
free_slot(H, H-_).

% extracting a name from a pair
extract_name(_-N, N).
*/


