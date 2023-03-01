```elixir

## INSERT a Pet
iex> pet = %Pet{name: "Mora I", age: 1, type: "Dog"}               
iex> Repo.insert(pet)
[debug] QUERY OK db=38.5ms queue=0.1ms idle=217.4ms
INSERT INTO "pets" ("age","name","type","inserted_at","updated_at") VALUES ($1,$2,$3,$4,$5) RETURNING "id" [1, "Mora I", "Dog", ~N[2023-02-28 17:57:39], ~N[2023-02-28 17:57:39]]
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
{:ok,
 %PetClinic.PetClinicServer.Pet{
   __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
   id: 7,
   age: 1,
   name: "Mora I",
   type: "Dog",
   inserted_at: ~N[2023-02-28 17:57:39],
   updated_at: ~N[2023-02-28 17:57:39]
 }}

## QUERY a Pet
iex> Repo.all(from p in Pet, where: p.age == 8, order_by: [p.name])
[debug] QUERY OK source="pets" db=24.3ms queue=0.1ms idle=1071.0ms
SELECT p0."id", p0."age", p0."name", p0."type", p0."inserted_at", p0."updated_at" FROM "pets" AS p0 WHERE (p0."age" = 8) ORDER BY p0."name" []
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
[
  %PetClinic.PetClinicServer.Pet{
    __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
    id: 4,
    age: 8,
    name: "Mish Tata",
    type: "Cat",
    inserted_at: ~N[2023-02-28 17:28:40],
    updated_at: ~N[2023-02-28 17:28:40]
  },
  %PetClinic.PetClinicServer.Pet{
    __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
    id: 3,
    age: 8,
    name: "Mora",
    type: "Dog",
    inserted_at: ~N[2023-02-28 17:28:18],
    updated_at: ~N[2023-02-28 17:28:18]
  }
]

## UPDATE a Pet
iex> [pet] =  Repo.all(from p in Pet, where: p.name == "Mora")
iex> change =  Ecto.Changeset.change(pet, age: 7)             
iex> Repo.update(change)                                      
[debug] QUERY OK db=4.6ms queue=1.4ms idle=1980.1ms
UPDATE "pets" SET "age" = $1, "updated_at" = $2 WHERE "id" = $3 [7, ~N[2023-02-28 17:49:08], 3]
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
{:ok,
 %PetClinic.PetClinicServer.Pet{
   __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
   id: 3,
   age: 7,
   name: "Mora",
   type: "Dog",
   inserted_at: ~N[2023-02-28 17:28:18],
   updated_at: ~N[2023-02-28 17:49:08]
 }}
iex> Repo.all(from p in Pet, where: p.type == "Dog", order_by: [p.age])
 [debug] QUERY OK source="pets" db=3.1ms queue=4.7ms idle=1114.3ms
 SELECT p0."id", p0."age", p0."name", p0."type", p0."inserted_at", p0."updated_at" FROM "pets" AS p0 WHERE (p0."type" = 'Dog') ORDER BY p0."age" []
 ↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
 [
   %PetClinic.PetClinicServer.Pet{
     __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
     id: 6,
     age: 1,
     name: "Tobby",
     type: "Dog",
     inserted_at: ~N[2023-02-28 17:29:28],
     updated_at: ~N[2023-02-28 17:29:28]
   },
   %PetClinic.PetClinicServer.Pet{
     __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
     id: 5,
     age: 3,
     name: "Puguie",
     type: "Dog",
     inserted_at: ~N[2023-02-28 17:29:01],
     updated_at: ~N[2023-02-28 17:29:01]
   },
   %PetClinic.PetClinicServer.Pet{
     __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
     id: 1,
     age: 5,
     name: "nuevito",
     type: "Dog",
     inserted_at: ~N[2023-02-27 14:20:14],
     updated_at: ~N[2023-02-27 14:20:14]
   },
   %PetClinic.PetClinicServer.Pet{
     __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
     id: 3,
     age: 8,
     name: "Mora",
     type: "Dog",
     inserted_at: ~N[2023-02-28 17:28:18],
     updated_at: ~N[2023-02-28 17:28:18]
   }
 ]
 
## DELETE a Pet 
iex> [pet] =  Repo.all(from p in Pet, where: p.name == "nuevito")
iex> Repo.delete(pet)                                            
[debug] QUERY OK db=4.3ms queue=1.0ms idle=1925.6ms
DELETE FROM "pets" WHERE "id" = $1 [1]
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
{:ok,
 %PetClinic.PetClinicServer.Pet{
   __meta__: #Ecto.Schema.Metadata<:deleted, "pets">,
   id: 1,
   age: 5,
   name: "nuevito",
   type: "Dog",
   inserted_at: ~N[2023-02-27 14:20:14],
   updated_at: ~N[2023-02-27 14:20:14]
 }}
iex> Repo.all(Pet)   
[debug] QUERY OK source="pets" db=1.9ms queue=0.1ms idle=269.4ms
SELECT p0."id", p0."age", p0."name", p0."type", p0."inserted_at", p0."updated_at" FROM "pets" AS p0 []
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
[
  %PetClinic.PetClinicServer.Pet{
    __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
    id: 2,
    age: 1,
    name: "Haru",
    type: "Cat",
    inserted_at: ~N[2023-02-27 15:14:17],
    updated_at: ~N[2023-02-27 15:14:17]
  },
  %PetClinic.PetClinicServer.Pet{
    __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
    id: 4,
    age: 8,
    name: "Mish Tata",
    type: "Cat",
    inserted_at: ~N[2023-02-28 17:28:40],
    updated_at: ~N[2023-02-28 17:28:40]
  },
  %PetClinic.PetClinicServer.Pet{
    __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
    id: 5,
    age: 3,
    name: "Puguie",
    type: "Dog",
    inserted_at: ~N[2023-02-28 17:29:01],
    updated_at: ~N[2023-02-28 17:29:01]
  },
  %PetClinic.PetClinicServer.Pet{
    __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
    id: 6,
    age: 1,
    name: "Tobby",
    type: "Dog",
    inserted_at: ~N[2023-02-28 17:29:28],
    updated_at: ~N[2023-02-28 17:29:28]
  },
  %PetClinic.PetClinicServer.Pet{
    __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
    id: 3,
    age: 7,
    name: "Mora",
    type: "Dog",
    inserted_at: ~N[2023-02-28 17:28:18],
    updated_at: ~N[2023-02-28 17:49:08]
  }
]

## INSERT a Veterinarian
iex> Repo.insert(%Vet{name: "Esther Ríos", age: 22, email: "esther@vet.com", specialities: "Dog, Cat, Bird, Fish"})
iex> Repo.all(Vet)                                                                                                 
[debug] QUERY OK source="vets" db=3.2ms idle=1759.5ms
SELECT v0."id", v0."age", v0."email", v0."name", v0."specialities", v0."inserted_at", v0."updated_at" FROM "vets" AS v0 []
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
[
  %PetClinic.PetHealthExpert.Vet{
    __meta__: #Ecto.Schema.Metadata<:loaded, "vets">,
    id: 1,
    age: 23,
    email: "joca@vet.com",
    name: "Joca",
    specialities: "birds",
    inserted_at: ~N[2023-02-27 17:30:07],
    updated_at: ~N[2023-02-27 17:30:07]
  },
  %PetClinic.PetHealthExpert.Vet{
    __meta__: #Ecto.Schema.Metadata<:loaded, "vets">,
    id: 2,
    age: 22,
    email: "esther@vet.com",
    name: "Esther Ríos",
    specialities: "Dog, Cat, Bird, Fish",
    inserted_at: ~N[2023-02-28 17:59:43],
    updated_at: ~N[2023-02-28 17:59:43]
  }
]

## DELETE a Veterinarian
iex> vet = Repo.get(Vet, 3) 
iex> Repo.delete(vet)      
[debug] QUERY OK db=45.3ms queue=1.2ms idle=1320.8ms
DELETE FROM "vets" WHERE "id" = $1 [3]
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
{:ok,
 %PetClinic.PetHealthExpert.Vet{
   __meta__: #Ecto.Schema.Metadata<:deleted, "vets">,
   id: 3,
   age: 15,
   email: "apprentice@vet.com",
   name: "Vet Apprentice",
   specialities: "",
   inserted_at: ~N[2023-02-28 18:02:48],
   updated_at: ~N[2023-02-28 18:02:48]
 }}
iex> Repo.all(Vet)
[debug] QUERY OK source="vets" db=3.0ms queue=0.1ms idle=173.0ms
SELECT v0."id", v0."age", v0."email", v0."name", v0."specialities", v0."inserted_at", v0."updated_at" FROM "vets" AS v0 []
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
[
  %PetClinic.PetHealthExpert.Vet{
    __meta__: #Ecto.Schema.Metadata<:loaded, "vets">,
    id: 1,
    age: 23,
    email: "joca@vet.com",
    name: "Joca",
    specialities: "birds",
    inserted_at: ~N[2023-02-27 17:30:07],
    updated_at: ~N[2023-02-27 17:30:07]
  },
  %PetClinic.PetHealthExpert.Vet{
    __meta__: #Ecto.Schema.Metadata<:loaded, "vets">,
    id: 2,
    age: 22,
    email: "esther@vet.com",
    name: "Esther Ríos",
    specialities: "Dog, Cat, Bird, Fish",
    inserted_at: ~N[2023-02-28 17:59:43],
    updated_at: ~N[2023-02-28 17:59:43]
  }
]

## UPDATE a Veterinarian
iex> vet = Repo.get(Vet, 1)                                    
iex> change =  Ecto.Changeset.change(vet, specialities: "Bird")
iex> Repo.update(change)                                       
[debug] QUERY OK db=5.6ms queue=1.4ms idle=1337.6ms
UPDATE "vets" SET "specialities" = $1, "updated_at" = $2 WHERE "id" = $3 ["Bird", ~N[2023-02-28 18:09:05], 1]
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
{:ok,
 %PetClinic.PetHealthExpert.Vet{
   __meta__: #Ecto.Schema.Metadata<:loaded, "vets">,
   id: 1,
   age: 23,
   email: "joca@vet.com",
   name: "Joca",
   specialities: "Bird",
   inserted_at: ~N[2023-02-27 17:30:07],
   updated_at: ~N[2023-02-28 18:09:05]
 }}
iex> Repo.get(Vet, 1)                                          
[debug] QUERY OK source="vets" db=1.7ms queue=0.2ms idle=1700.2ms
SELECT v0."id", v0."age", v0."email", v0."name", v0."specialities", v0."inserted_at", v0."updated_at" FROM "vets" AS v0 WHERE (v0."id" = $1) [1]
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
%PetClinic.PetHealthExpert.Vet{
  __meta__: #Ecto.Schema.Metadata<:loaded, "vets">,
  id: 1,
  age: 23,
  email: "joca@vet.com",
  name: "Joca",
  specialities: "Bird",
  inserted_at: ~N[2023-02-27 17:30:07],
  updated_at: ~N[2023-02-28 18:09:05]
}


## ADDING ASSOCIASIONS Pet-Owner
iex> import Ecto.Changeset

iex> pet = Repo.get_by(Pet, name: "Haru") |> Repo.preload(:owner)
iex> owner = Repo.get_by(Owner, name: "Caleb") |> Repo.preload(:pets)
iex> chaset = pet |> change |> put_assoc(:owner, owner)               
iex> Repo.update(chaset)
[debug] QUERY OK db=0.5ms idle=1171.6ms
begin []
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
[debug] QUERY OK db=2.0ms
UPDATE "pets" SET "owner_id" = $1, "updated_at" = $2 WHERE "id" = $3 [1, ~N[2023-03-01 01:13:58], 3]
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
[debug] QUERY OK db=5.2ms
commit []
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
{:ok,
 %PetClinic.PetClinicServer.Pet{
   __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
   id: 3,
   age: 1,
   name: "Haru",
   sex: "male",
   type: "Cat",
   owner_id: 1,
   owner: %PetClinic.PetClinicServer.Owner{
     __meta__: #Ecto.Schema.Metadata<:loaded, "owners">,
     id: 1,
     age: 24,
     email: "caleb@bunsan.io",
     name: "Caleb",
     phone_num: "4431304124",
     pets: [],
     inserted_at: ~N[2023-03-01 00:14:57],
     updated_at: ~N[2023-03-01 00:14:57]
   },
   vet_id: nil,
   vet: #Ecto.Association.NotLoaded<association :vet is not loaded>,
   inserted_at: ~N[2023-03-01 00:10:58],
   updated_at: ~N[2023-03-01 01:13:58]
 }}


## ADDING ASSOCIASIONS Pet-Vet
iex> pet = Repo.get_by(Pet, name: "Mora") |> Repo.preload(:preferred_expert)        
iex> vet  = Repo.get_by(Vet, name: "Esther") |> Repo.preload(:patients)
iex> chaset = pet |> change |> put_assoc(:preferred_expert, vet)                    
iex> Repo.update(chaset)                                               
[debug] QUERY OK db=0.3ms idle=1975.2ms
begin []
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
[debug] QUERY OK db=1.3ms
UPDATE "pets" SET "preferred_expert_id" = $1, "updated_at" = $2 WHERE "id" = $3 [2, ~N[2023-03-01 16:53:27], 1]
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
[debug] QUERY OK db=3.6ms
commit []
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
{:ok,
 %PetClinic.PetClinicServer.Pet{
   __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
   id: 1,
   age: 7,
   name: "Mora",
   sex: :female,
   type: "Dog",
   owner_id: nil,
   owner: #Ecto.Association.NotLoaded<association :owner is not loaded>,
   preferred_expert_id: 2,
   preferred_expert: %PetClinic.PetClinicServer.Vet{
     __meta__: #Ecto.Schema.Metadata<:loaded, "vets">,
     id: 2,
     age: 22,
     email: "esther@vet.com",
     name: "Esther",
     specialities: "Dog, Cat, Fish, Bird",
     patients: [],
     inserted_at: ~N[2023-03-01 00:14:08],
     updated_at: ~N[2023-03-01 00:14:08]
   },
   inserted_at: ~N[2023-03-01 00:10:01],
   updated_at: ~N[2023-03-01 16:53:27]
 }}

## Charset validations
iex(2)> changeset = Pet.changeset(%Pet{}, %{age: 201})                          #Ecto.
iex(3)> {:error, changeset} = Repo.insert(changeset)
{:error,
 #Ecto.Changeset<
   action: :insert,
   changes: %{age: 201},
   errors: [
     age: {"is invalid", [validation: :inclusion, enum: 0..200]},
     name: {"can't be blank", [validation: :required]},
     type: {"can't be blank", [validation: :required]},
     sex: {"can't be blank", [validation: :required]}
   ],
   data: #PetClinic.PetClinicServer.Pet<>,
   valid?: false
 >}

iex(5)> changeset = Pet.changeset(%Pet{}, %{age: -201})
iex(6)> {:error, changeset} = Repo.insert(changeset)   
iex(7)> changeset.errors
[
  age: {"is invalid", [validation: :inclusion, enum: 0..200]},
  name: {"can't be blank", [validation: :required]},
  type: {"can't be blank", [validation: :required]},
  sex: {"can't be blank", [validation: :required]}
]

iex(8)> changeset = Owner.changeset(%Owner{}, %{age: -201})
iex(9)> {:error, changeset} = Repo.insert(changeset)       
iex(10)> changeset.errors                                   
[
  age: {"is invalid", [validation: :inclusion, enum: 0..120]},
  name: {"can't be blank", [validation: :required]},
  email: {"can't be blank", [validation: :required]},
  phone_num: {"can't be blank", [validation: :required]}
]


## Sex Pet

iex(8)> pet = %Pet{name: "Xolo", type: "Dog", age: 4, sex: "male"}
iex(9)> Repo.insert(pet)                                          
** (Ecto.ChangeError) value `"male"` for `PetClinic.PetClinicServer.Pet.sex` in `insert` does not match type {:parameterized, Ecto.Enum, %{embed_as: :self, mappings: [male: "male", female: "female"], on_cast: %{"female" => :female, "male" => :male}, on_dump: %{female: "female", male: "male"}, on_load: %{"female" => :female, "male" => :male}, type: :string}}
    (ecto 3.9.4) lib/ecto/repo/schema.ex:1010: Ecto.Repo.Schema.dump_field!/6
    (ecto 3.9.4) lib/ecto/repo/schema.ex:1019: anonymous fn/6 in Ecto.Repo.Schema.dump_fields!/5
    (stdlib 4.0) maps.erl:411: :maps.fold_1/3
    (ecto 3.9.4) lib/ecto/repo/schema.ex:1017: Ecto.Repo.Schema.dump_fields!/5
    (ecto 3.9.4) lib/ecto/repo/schema.ex:951: Ecto.Repo.Schema.dump_changes!/7
    (ecto 3.9.4) lib/ecto/repo/schema.ex:359: anonymous fn/15 in Ecto.Repo.Schema.do_insert/4
iex(9)> pet = %Pet{name: "Xolo", type: "Dog", age: 4, sex: :male} 
iex(10)> Repo.insert(pet)                                         
[debug] QUERY OK db=7.5ms queue=2.9ms idle=1946.8ms
INSERT INTO "pets" ("age","name","sex","type","inserted_at","updated_at") VALUES ($1,$2,$3,$4,$5,$6) RETURNING "id" [4, "Xolo", :male, "Dog", ~N[2023-03-01 16:56:59], ~N[2023-03-01 16:56:59]]
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
{:ok,
 %PetClinic.PetClinicServer.Pet{
   __meta__: #Ecto.Schema.Metadata<:loaded, "pets">,
   id: 8,
   age: 4,
   name: "Xolo",
   sex: :male,
   type: "Dog",
   owner_id: nil,
   owner: #Ecto.Association.NotLoaded<association :owner is not loaded>,
   preferred_expert_id: nil,
   preferred_expert: #Ecto.Association.NotLoaded<association :preferred_expert is not loaded>,
   inserted_at: ~N[2023-03-01 16:56:59],
   updated_at: ~N[2023-03-01 16:56:59]
 }}

## Sex Vet
iex(4)> vet = %Vet{name: "Dogtora", age: 25, email: "dogtora@vet.com", specialities: "Dog", sex: "feeemale"}
iex(5)> Repo.insert(vet)                                                                                    
** (Ecto.ChangeError) value `"feeemale"` for `PetClinic.PetClinicServer.Vet.sex` in `insert` does not match type {:parameterized, Ecto.Enum, %{embed_as: :self, mappings: [male: "male", female: "female"], on_cast: %{"female" => :female, "male" => :male}, on_dump: %{female: "female", male: "male"}, on_load: %{"female" => :female, "male" => :male}, type: :string}}
    (ecto 3.9.4) lib/ecto/repo/schema.ex:1010: Ecto.Repo.Schema.dump_field!/6
    (ecto 3.9.4) lib/ecto/repo/schema.ex:1019: anonymous fn/6 in Ecto.Repo.Schema.dump_fields!/5
    (stdlib 4.0) maps.erl:411: :maps.fold_1/3
    (ecto 3.9.4) lib/ecto/repo/schema.ex:1017: Ecto.Repo.Schema.dump_fields!/5
    (ecto 3.9.4) lib/ecto/repo/schema.ex:951: Ecto.Repo.Schema.dump_changes!/7
    (ecto 3.9.4) lib/ecto/repo/schema.ex:359: anonymous fn/15 in Ecto.Repo.Schema.do_insert/4

iex(5)> vet = %Vet{name: "Dogtora", age: 25, email: "dogtora@vet.com", specialities: "Dog", sex: :female}   
iex(6)> Repo.insert(vet)                                                                                 
[debug] QUERY OK db=5.5ms queue=2.7ms idle=1838.0ms
INSERT INTO "vets" ("age","email","name","sex","specialities","inserted_at","updated_at") VALUES ($1,$2,$3,$4,$5,$6,$7) RETURNING "id" [25, "dogtora@vet.com", "Dogtora", :female, "Dog", ~N[2023-03-01 17:16:59], ~N[2023-03-01 17:16:59]]
↳ :erl_eval.do_apply/7, at: erl_eval.erl:744
{:ok,
 %PetClinic.PetClinicServer.Vet{
   __meta__: #Ecto.Schema.Metadata<:loaded, "vets">,
   id: 4,
   age: 25,
   email: "dogtora@vet.com",
   name: "Dogtora",
   specialities: "Dog",
   sex: :female,
   patients: #Ecto.Association.NotLoaded<association :patients is not loaded>,
   inserted_at: ~N[2023-03-01 17:16:59],
   updated_at: ~N[2023-03-01 17:16:59]
 }}
```