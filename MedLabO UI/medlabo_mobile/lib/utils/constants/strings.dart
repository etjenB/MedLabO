const String appTitle = 'MedLabO';

//Roles enum
enum RolesEnum { administrator, medicinskoOsoblje, pacijent }

final Map<RolesEnum, String> roles = {
  RolesEnum.administrator: 'Administrator',
  RolesEnum.medicinskoOsoblje: 'MedicinskoOsoblje',
  RolesEnum.pacijent: 'Pacijent',
};
