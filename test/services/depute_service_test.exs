defmodule An.DeputeServiceTest do
  use An.ModelCase

  alias An.Commune
  alias An.Depute
  alias An.Organe
  alias An.Mandat
  alias An.DeputeService

  test "should retrieve depute from given code_postal" do
    Repo.insert! %Commune{code_postaux: [12_345], numero_circonscription: 1, numero_departement: "12"}
    assemblee = Repo.insert! %Organe{code_type: "ASSEMBLEE", uid: "a"}
    depute = Repo.insert! %Depute{uid: "d"}
    mandat = Repo.insert! %Mandat{
      organe_uid: assemblee.uid,
      depute_uid: depute.uid,
      raw_json: %{
        "@xsi:type": "MandatParlementaire_type",
        "election": %{
          "lieu": %{
            "numCirco": "1",
            "numDepartement": "12"
          }
        }
      },
      uid: "m"
    }

    assert DeputeService.get_depute_of_commune(12_345) == depute
  end

  test "should retrieve the parti politique of a depute" do
    depute = Repo.insert! %Depute{uid: "d"}
    parpol = Repo.insert! %Organe{code_type: "PARPOL", uid: "p"}
    mandat = Repo.insert! %Mandat{
      organe_uid: parpol.uid,
      depute_uid: depute.uid,
      uid: "m"
    }

    assert DeputeService.get_parpol_of_depute(depute) == parpol
  end
end
