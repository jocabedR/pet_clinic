import Ecto.Query
import Ecto.Changeset
alias PetClinic.Repo

alias PetClinic.PetClinicServer.Pet
alias PetClinic.PetClinicServer.PetType
alias PetClinic.PetClinicServer.Vet
alias PetClinic.PetClinicServer.Owner
alias PetClinic.PetClinicServer.ExpertSpeciality

# Preload associations
Enum.each(Repo.all(Pet), fn pet ->
  pet
  |> Repo.preload(:owner)
  |> Repo.preload(:preferred_expert)
  |> Repo.preload(:type)
end)

Enum.each(Repo.all(Vet), fn vet ->
  Repo.preload(vet, :patients)
  Repo.preload(vet, :expert_specialities)
end)
