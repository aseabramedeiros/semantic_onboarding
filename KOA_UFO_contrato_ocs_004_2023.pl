% ===== KOA Combined Output | contract_id: contrato_ocs_004_2023 =====

% ===== 1) UFO Ontology =====
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY EM PROLOG
% Inspirada em UFO-L + UFO-S + Service Contract Ontology (Griffo et al., 2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% META-ESTRUTURA (TBox: classes, especializações, relações entre classes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicados básicos de metamodelo
class(C).          % C é uma classe ontológica
subclass_of(C, P). % C é subclasse de P
disjoint(C1, C2).  % C1 e C2 são disjuntas conceitualmente

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Núcleo UFO-A / UFO-C simplificado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(agent).           % agente (pessoa, organização etc.)
class(relator).         % relator genérico
class(moment).          % propriedade/momento (trope no sentido do UFO)

class(social_relator).
class(legal_relator).

subclass_of(social_relator, relator).
subclass_of(legal_relator, social_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEGAL MOMENTS E LEGAL RELATORS (UFO-L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(legal_moment).
class(legal_entitlement).      % vantagens jurídicas
class(legal_burden_or_lack).  % ônus / falta de prerrogativa

subclass_of(legal_entitlement, legal_moment).
subclass_of(legal_burden_or_lack, legal_moment).

% Tipos de legal relators
class(simple_legal_relator).
class(complex_legal_relator).

subclass_of(simple_legal_relator, legal_relator).
subclass_of(complex_legal_relator, legal_relator).

% ---------------------------------------------------------------------------
% Right / Duty
% ---------------------------------------------------------------------------

class(right).
class(right_to_action).
class(right_to_omission).

class(duty).
class(duty_to_act).
class(duty_to_omit).

subclass_of(right, legal_entitlement).
subclass_of(right_to_action, right).
subclass_of(right_to_omission, right).

subclass_of(duty, legal_burden_or_lack).
subclass_of(duty_to_act, duty).
subclass_of(duty_to_omit, duty).

% ---------------------------------------------------------------------------
% NoRight / Permission
% ---------------------------------------------------------------------------

class(no_right).
class(no_right_to_action).
class(no_right_to_omission).

class(permission).
class(permission_to_act).
class(permission_to_omit).

subclass_of(no_right, legal_burden_or_lack).
subclass_of(no_right_to_action, no_right).
subclass_of(no_right_to_omission, no_right).

subclass_of(permission, legal_entitlement).
subclass_of(permission_to_act, permission).
subclass_of(permission_to_omit, permission).

% ---------------------------------------------------------------------------
% Power / Subjection (Liability)
% ---------------------------------------------------------------------------

class(power).
class(subjection).

subclass_of(power, legal_entitlement).
subclass_of(subjection, legal_burden_or_lack).

% ---------------------------------------------------------------------------
% Disability / Immunity
% ---------------------------------------------------------------------------

class(disability).
class(immunity).

subclass_of(disability, legal_burden_or_lack).
subclass_of(immunity, legal_entitlement).

% ---------------------------------------------------------------------------
% Liberty (liberdade desprotegida como complex legal relator)
% ---------------------------------------------------------------------------

class(liberty_relator).
subclass_of(liberty_relator, complex_legal_relator).

% ---------------------------------------------------------------------------
% Tipos de Simple Legal Relator (pares correlatos)
% ---------------------------------------------------------------------------

class(right_duty_relator).
class(noright_permission_relator).
class(power_subjection_relator).
class(disability_immunity_relator).

subclass_of(right_duty_relator, simple_legal_relator).
subclass_of(noright_permission_relator, simple_legal_relator).
subclass_of(power_subjection_relator, simple_legal_relator).
subclass_of(disability_immunity_relator, simple_legal_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CORRELAÇÃO ENTRE LEGAL MOMENTS (Hohfeld + Alexy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Correlatos em nível de classe
correlates(right_to_action,   duty_to_act).
correlates(duty_to_act,       right_to_action).

correlates(right_to_omission, duty_to_omit).
correlates(duty_to_omit,      right_to_omission).

correlates(permission_to_act,     no_right_to_action).
correlates(no_right_to_action,    permission_to_act).

correlates(permission_to_omit,    no_right_to_omission).
correlates(no_right_to_omission,  permission_to_omit).

correlates(power,      subjection).
correlates(subjection, power).

correlates(disability, immunity).
correlates(immunity,   disability).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE RELATIONS E SERVICE CONTRACTS (núcleo UFO-S simplificado)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(service_relation).
class(service_agreement).
class(legal_service_agreement).

subclass_of(service_agreement, service_relation).
subclass_of(legal_service_agreement, service_agreement).

% Papéis em relações de serviço
class(service_provider_role).
class(target_customer_role).
class(hired_service_provider_role).
class(service_customer_role).

subclass_of(hired_service_provider_role, service_provider_role).
subclass_of(service_customer_role,       target_customer_role).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY (Fig. 4 do artigo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Em um Legal Service Agreement, cada parte tem Entitlements e Burdens/Lacks
class(hsp_entitlement).      % Hired Service Provider Entitlement
class(hsp_burden_or_lack).   % Hired Service Provider Burden/Lack
class(sc_entitlement).       % Service Customer Entitlement
class(sc_burden_or_lack).    % Service Customer Burden/Lack

subclass_of(hsp_entitlement, legal_entitlement).
subclass_of(sc_entitlement,  legal_entitlement).

subclass_of(hsp_burden_or_lack, legal_burden_or_lack).
subclass_of(sc_burden_or_lack,  legal_burden_or_lack).

% Composição: um Legal Service Agreement é composto de legal moments
% associados a cada papel (provider x customer).
relator_component(legal_service_agreement, hsp_entitlement).
relator_component(legal_service_agreement, hsp_burden_or_lack).
relator_component(legal_service_agreement, sc_entitlement).
relator_component(legal_service_agreement, sc_burden_or_lack).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESQUEMA PARA INSTÂNCIAS (ABox): AGENTES, ACORDOS, CLÁUSULAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% instance_of(Instancia, Classe).
% Você vai usar isso para criar indivíduos (contratos, cláusulas, agentes...).

:- dynamic instance_of/2.
:- dynamic plays_role/3.
:- dynamic legal_relation_instance/4.
:- dynamic clause_of/2.

% plays_role(Agente, Papel, Acordo).
% Ex.: plays_role(aws, hired_service_provider_role, aws_sns_agreement).
%      plays_role(cliente_x, service_customer_role, aws_sns_agreement).
plays_role(Agent, Role, Agreement).

% clause_of(ClauseId, Agreement).
% ClauseId é uma cláusula (ou grupo de cláusulas) de um acordo específico.
clause_of(ClauseId, Agreement).

% legal_relation_instance(ClauseId, LegalMoment, Bearer, Action).
%
% ClauseId   - identificador da cláusula
% LegalMoment- classe do momento jurídico (duty_to_omit, power, immunity...)
% Bearer     - quem tem esse momento (agente ou papel)
% Action     - ação/omissão ou descrição da conduta
%
% Exemplos (para você popular depois, inspirados no artigo):
% legal_relation_instance(clause_17_1, duty_to_omit, customer, share_service_with_third_parties).
% legal_relation_instance(clause_17_1, right_to_omission, provider, share_service_with_third_parties).

legal_relation_instance(ClauseId, LegalMomentClass, Bearer, Action) :-
    clause_of(ClauseId, _Agreement),
    class(LegalMomentClass),
    (   atom(Bearer)
    ;   plays_role(Bearer, _, _)
    ),
    atom(Action).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REGRAS AUXILIARES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fecho transitivo de subclass_of/2
subclass_of_trans(C, P) :-
    subclass_of(C, P).
subclass_of_trans(C, P) :-
    subclass_of(C, X),
    subclass_of_trans(X, P).

% is_a(Inst, Classe) — verifica se Inst é instância (direta ou indireta) de Classe
is_a(Inst, Classe) :-
    instance_of(Inst, C0),
    (   C0 = Classe
    ;   subclass_of_trans(C0, Classe)
    ).

% um legal_moment é um entitlement se a classe dele cai abaixo de legal_entitlement
is_entitlement(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_entitlement).

% um legal_moment é um burden/lack se cai abaixo de legal_burden_or_lack
is_burden_or_lack(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_burden_or_lack).

% Dado um LegalMomentClass, encontrar seu correlato (em termos de classe)
correlative_class(LMClass, CorrelateClass) :-
    correlates(LMClass, CorrelateClass).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIM DA ONTOLOGIA BASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ===== 2) Generated UFO ABox =====
% UFO-only grounding generated from: KOA_Contrato_OCS_134_2023_-_Daten.pl
% contract_id: contrato_ocs_004_2023

instance_of(contrato_ocs_004_2023, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social, agent).
instance_of(daten_tecnologia_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social, service_customer_role, contrato_ocs_004_2023).
plays_role(daten_tecnologia_ltda, hired_service_provider_role, contrato_ocs_004_2023).

clause_of(clausula_primeira_objeto, contrato_ocs_004_2023).
clause_of(clausula_segunda_vigencia, contrato_ocs_004_2023).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_004_2023).
clause_of(clausula_quarta_recebimento_objeto, contrato_ocs_004_2023).
clause_of(clausula_quinta_garantia_dos_bens_fornecidos, contrato_ocs_004_2023).
clause_of(clausula_sexta_preco, contrato_ocs_004_2023).
clause_of(clausula_setima_pagamento, contrato_ocs_004_2023).
clause_of(clausula_oitava_equilibrio_economico_financeiiflo_contrato, contrato_ocs_004_2023).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_004_2023).
clause_of(clausula_decima_garantia_contratual, contrato_ocs_004_2023).
clause_of(clausula_decima_primeira_obrigações_contratado, contrato_ocs_004_2023).
clause_of(clausula_decima_segunda_conduta_etica_contratado_bndes, contrato_ocs_004_2023).
clause_of(clausula_decima_terceira_sigilo_informacões, contrato_ocs_004_2023).
clause_of(clausula_decima_quarta_acesso_protecao_dados_pessoais, contrato_ocs_004_2023).
clause_of(clausula_decima_quinta_obrigações_bndes, contrato_ocs_004_2023).
clause_of(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, contrato_ocs_004_2023).
clause_of(clausula_decima_setima_cessão_contrato_credito_sucessão_subcontratação, contrato_ocs_004_2023).
clause_of(clausula_decima_oitava_penalidades, contrato_ocs_004_2023).
clause_of(clausula_decima_nona_alteracoes_contratuais, contrato_ocs_004_2023).
clause_of(clausula_vigésima_extincao_contrato, contrato_ocs_004_2023).
clause_of(clausula_vigésima_primeira_disposicoes_finais, contrato_ocs_004_2023).
clause_of(clausula_vigésima_segunda_foro, contrato_ocs_004_2023).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, daten_tecnologia_ltda, supply_notebooks).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social, receive_notebooks).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social, act_under_contract_for_6_months).
legal_relation_instance(clausula_segunda_vigencia, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social, right_to_act_under_contract_for_6_months).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, daten_tecnologia_ltda, execute_contract_object).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social, expect_execution_according_to_specifications).
legal_relation_instance(clausula_quarta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social, effect_object_receipt).
legal_relation_instance(clausula_quarta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social, effect_object_receipt).
legal_relation_instance(clausula_quinta_garantia_dos_bens_fornecidos, duty_to_act, daten_tecnologia_ltda, solve_defects).
legal_relation_instance(clausula_quinta_garantia_dos_bens_fornecidos, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social, demand_defect_solution).
legal_relation_instance(clausula_sexta_preco, duty_to_act, daten_tecnologia_ltda, bear_onus_of_error).
legal_relation_instance(clausula_sexta_preco, duty_to_act, daten_tecnologia_ltda, execute_contract_object).
legal_relation_instance(clausula_sexta_preco, right_to_action, daten_tecnologia_ltda, receive_payment).
legal_relation_instance(clausula_sexta_preco, power, banco_nacional_de_desenvolvimento_economico_e_social, promote_negotiation).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social, efetuar_pagamento).
legal_relation_instance(clausula_setima_pagamento, right_to_action, daten_tecnologia_ltda, receive_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, daten_tecnologia_ltda, apresentar_documento_fiscal).
legal_relation_instance(clausula_setima_pagamento, power, banco_nacional_de_desenvolvimento_economico_e_social, deduzir_valor).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social, ressarcir_se).
legal_relation_instance(clausula_setima_pagamento, right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social, omitir_pagamento).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiiflo_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social, revise_prices).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiiflo_contrato, right_to_action, daten_tecnologia_ltda, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiiflo_contrato, duty_to_act, daten_tecnologia_ltda, request_price_revision_before_end).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiiflo_contrato, no_right_to_action, daten_tecnologia_ltda, request_price_revision_after_deadline).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiiflo_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social, analyze_price_revision).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_omit, daten_tecnologia_ltda, omit_celebration_of_additives).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, daten_tecnologia_ltda, no_right_to_celebrate_additives).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, daten_tecnologia_ltda, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, daten_tecnologia_ltda, complement_or_renew_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, daten_tecnologia_ltda, obtain_guarantor_consent).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, daten_tecnologia_ltda, obtain_new_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, power, banco_nacional_de_desenvolvimento_economico_e_social, extend_guarantee_period).
legal_relation_instance(clausula_decima_garantia_contratual, power, banco_nacional_de_desenvolvimento_economico_e_social, demand_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, right_to_action, daten_tecnologia_ltda, request_extension_for_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, permission_to_act, daten_tecnologia_ltda, request_extension_for_guarantee).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, daten_tecnologia_ltda, maintain_habilitation_conditions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, daten_tecnologia_ltda, notify_penalty_impediment).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, daten_tecnologia_ltda, repair_contract_object).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, daten_tecnologia_ltda, repair_damages_to_bndes_or_third_parties).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, daten_tecnologia_ltda, pay_all_charges_and_taxes).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, daten_tecnologia_ltda, assume_responsibility_for_burdens).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, daten_tecnologia_ltda, provide_exclusion_from_simples_nacional).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, daten_tecnologia_ltda, allow_inspections).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, daten_tecnologia_ltda, obey_instructions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, daten_tecnologia_ltda, designate_representative).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, daten_tecnologia_ltda, maintain_integrity_in_public_private_relations).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, daten_tecnologia_ltda, act_in_good_faith).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_omit, daten_tecnologia_ltda, not_offer_undue_advantage).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, daten_tecnologia_ltda, prevent_favorecimento).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, daten_tecnologia_ltda, prevent_allocation_of_relatives).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, daten_tecnologia_ltda, observe_bndes_policies).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, daten_tecnologia_ltda, adopt_good_environmental_practices).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, daten_tecnologia_ltda, oust_agents_involved_in_irregularities).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratado_bndes, duty_to_act, daten_tecnologia_ltda, notify_bndes_of_irregularities).
legal_relation_instance(clausula_decima_terceira_sigilo_informacões, duty_to_act, daten_tecnologia_ltda, maintain_confidentiality).
legal_relation_instance(clausula_decima_terceira_sigilo_informacões, duty_to_act, daten_tecnologia_ltda, ensure_professionals_sign_confidentiality_terms).
legal_relation_instance(clausula_decima_terceira_sigilo_informacões, power, banco_nacional_de_desenvolvimento_economico_e_social, request_confidentiality_agreements).
legal_relation_instance(clausula_decima_terceira_sigilo_informacões, subjection, daten_tecnologia_ltda, sign_confidentiality_agreements).
legal_relation_instance(clausula_decima_terceira_sigilo_informacões, right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social, omit_access_to_confidential_info).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, daten_tecnologia_ltda, adopt_security_measures).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, daten_tecnologia_ltda, obtain_consent).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, daten_tecnologia_ltda, follow_bndes_instructions).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, daten_tecnologia_ltda, maintain_confidentiality).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social, right_of_recourse).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, daten_tecnologia_ltda, inform_bndes_of_requests).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, daten_tecnologia_ltda, communicate_incidents).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, daten_tecnologia_ltda, delete_personal_data).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social, approve_data_collection).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, daten_tecnologia_ltda, inform_employees).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social, make_payments_to_contratado).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, right_to_action, daten_tecnologia_ltda, receive_payments_from_bndes).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social, designate_contract_manager).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social, designate_manager_substitute).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social, alter_contract_manager).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social, designate_receipt_committee).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social, provide_contracted_party_with_ethics_code).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social, provide_necessary_information).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, right_to_action, daten_tecnologia_ltda, receive_necessary_information).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social, communicate_instructions_procedures).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, duty_to_act, daten_tecnologia_ltda, prove_no_discriminatory_practices).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social, request_proof_of_no_discriminatory_practices).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, power, banco_nacional_de_desenvolvimento_economico_e_social, suspend_contract_execution).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, disability, daten_tecnologia_ltda, prevent_contract_suspension).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_subcontratação, duty_to_omit, daten_tecnologia_ltda, omit_contract_assignment).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_subcontratação, no_right_to_action, daten_tecnologia_ltda, no_right_assign_contract).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_subcontratação, duty_to_omit, daten_tecnologia_ltda, omit_credit_assignment).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_subcontratação, no_right_to_action, daten_tecnologia_ltda, no_right_assign_credit).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_subcontratação, duty_to_omit, daten_tecnologia_ltda, omit_issuing_credit_title).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_subcontratação, no_right_to_action, daten_tecnologia_ltda, no_right_issue_credit_title).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_subcontratação, duty_to_omit, daten_tecnologia_ltda, omit_subcontracting).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_subcontratação, no_right_to_action, daten_tecnologia_ltda, no_right_subcontract).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_subcontratação, power, banco_nacional_de_desenvolvimento_economico_e_social, analyze_risks_prejudice).
legal_relation_instance(clausula_decima_setima_cessão_contrato_credito_sucessão_subcontratação, subjection, daten_tecnologia_ltda, be_subject_to_bndes_analysis).
legal_relation_instance(clausula_decima_oitava_penalidades, subjection, daten_tecnologia_ltda, subject_to_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, duty_to_act, daten_tecnologia_ltda, comply_with_bndes_requirements).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social, apply_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, duty_to_omit, daten_tecnologia_ltda, omit_illegal_acts).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social, nao_desnaturar_objeto).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social, nao_afetar_condicoes_essenciais).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social, alterar_contrato).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social, responder_por_danos).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social, formalizar_alteracao_contratual).
legal_relation_instance(clausula_vigésima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social, terminate_contract_consensually).
legal_relation_instance(clausula_vigésima_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social, provide_written_notice_of_termination).
legal_relation_instance(clausula_vigésima_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social, terminate_contract_for_breach).
legal_relation_instance(clausula_vigésima_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social, notify_of_breach_and_allow_cure).
legal_relation_instance(clausula_vigésima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social, terminate_contract_due_to_lack_of_release).
legal_relation_instance(clausula_vigésima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social, suspend_contract_execution).
legal_relation_instance(clausula_vigésima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social, terminate_contract_insolvency).
legal_relation_instance(clausula_vigésima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social, terminate_contract_loss_qualification).
legal_relation_instance(clausula_vigésima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social, terminate_contract_cessao_descumprimento).
legal_relation_instance(clausula_vigésima_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social, terminate_contract_due_to_corruption).
legal_relation_instance(clausula_vigésima_primeira_disposicoes_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social, waive_rights_by_omission).
legal_relation_instance(clausula_vigésima_primeira_disposicoes_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social, exercise_rights).
legal_relation_instance(clausula_vigésima_segunda_foro, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social, resolve_disputes_in_rio).
legal_relation_instance(clausula_vigésima_segunda_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social, litigate_elsewhere).
legal_relation_instance(clausula_vigésima_segunda_foro, subjection, banco_nacional_de_desenvolvimento_economico_e_social, be_subject_to_rio_court).

% --- Action catalog (local to this contract grounding) ---
action_type(act_in_good_faith).
action_label(act_in_good_faith, 'Act in good faith').
action_type(act_under_contract_for_6_months).
action_label(act_under_contract_for_6_months, 'Act under contract for 6 months').
action_type(adopt_good_environmental_practices).
action_label(adopt_good_environmental_practices, 'Adopt environmental practices').
action_type(adopt_security_measures).
action_label(adopt_security_measures, 'Adopt security measures').
action_type(adopt_sustainable_practices).
action_label(adopt_sustainable_practices, 'Adopt sustainable practices').
action_type(allow_inspections).
action_label(allow_inspections, 'Allow inspections').
action_type(alter_contract_manager).
action_label(alter_contract_manager, 'Alter contract manager').
action_type(alterar_contrato).
action_label(alterar_contrato, 'Alter contract').
action_type(analyze_price_revision).
action_label(analyze_price_revision, 'Analyze price revision request').
action_type(analyze_risks_prejudice).
action_label(analyze_risks_prejudice, 'Analyze risks and prejudice').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(approve_data_collection).
action_label(approve_data_collection, 'Approve data collection').
action_type(apresentar_documento_fiscal).
action_label(apresentar_documento_fiscal, 'Present fiscal document').
action_type(assume_responsibility_for_burdens).
action_label(assume_responsibility_for_burdens, 'Assume responsibility for burdens').
action_type(assume_technical_responsibility).
action_label(assume_technical_responsibility, 'Assume technical responsibility').
action_type(attend_to_bndes_requirements).
action_label(attend_to_bndes_requirements, 'Attend to BNDES requirements').
action_type(be_subject_to_bndes_analysis).
action_label(be_subject_to_bndes_analysis, 'Subject to BNDES analysis').
action_type(be_subject_to_rio_court).
action_label(be_subject_to_rio_court, 'Be subject to Rio de Janeiro court').
action_type(bear_onus_of_error).
action_label(bear_onus_of_error, 'Bear onus of error').
action_type(collect_consent).
action_label(collect_consent, 'Collect consent').
action_type(communicate_incidents).
action_label(communicate_incidents, 'Communicate Incidents').
action_type(communicate_instructions_procedures).
action_label(communicate_instructions_procedures, 'Communicate instructions').
action_type(communicate_investigation_procedure).
action_label(communicate_investigation_procedure, 'Communicate investigation').
action_type(communicate_penalty).
action_label(communicate_penalty, 'Communicate penalty').
action_type(complement_or_renew_guarantee).
action_label(complement_or_renew_guarantee, 'Complement/renew guarantee').
action_type(comply_with_bndes_requirements).
action_label(comply_with_bndes_requirements, 'Comply with BNDES requirements').
action_type(comply_with_laws).
action_label(comply_with_laws, 'Comply with laws').
action_type(comply_with_security_norms).
action_label(comply_with_security_norms, 'Comply with security norms').
action_type(deduzir_valor).
action_label(deduzir_valor, 'Deduct amount').
action_type(delete_personal_data).
action_label(delete_personal_data, 'Delete Personal Data').
action_type(demand_contractual_guarantee).
action_label(demand_contractual_guarantee, 'Demand guarantee').
action_type(demand_defect_solution).
action_label(demand_defect_solution, 'Demand defect solution').
action_type(demand_proof_tax_regularity).
action_label(demand_proof_tax_regularity, 'Demand proof tax regularity').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(designate_manager_substitute).
action_label(designate_manager_substitute, 'Designate manager substitute').
action_type(designate_receipt_committee).
action_label(designate_receipt_committee, 'Designate receipt committee').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(efetuar_pagamento).
action_label(efetuar_pagamento, 'Make payment').
action_type(effect_object_receipt).
action_label(effect_object_receipt, 'Effect object receipt').
action_type(ensure_professionals_sign_confidentiality_terms).
action_label(ensure_professionals_sign_confidentiality_terms, 'Ensure professionals sign confidentiality terms').
action_type(execute_contract_object).
action_label(execute_contract_object, 'Execute the object').
action_type(exercise_rights).
action_label(exercise_rights, 'Right to exercise rights').
action_type(expect_execution_according_to_specifications).
action_label(expect_execution_according_to_specifications, 'Expect execution per specifications').
action_type(extend_guarantee_period).
action_label(extend_guarantee_period, 'Extend guarantee period').
action_type(follow_bndes_instructions).
action_label(follow_bndes_instructions, 'Follow BNDES instructions').
action_type(formalizar_alteracao_contratual).
action_label(formalizar_alteracao_contratual, 'Formalize contract change').
action_type(identify_employees).
action_label(identify_employees, 'Identify employees').
action_type(inform_bndes_of_requests).
action_label(inform_bndes_of_requests, 'Inform BNDES of requests').
action_type(inform_employees).
action_label(inform_employees, 'Inform employees').
action_type(litigate_elsewhere).
action_label(litigate_elsewhere, 'Litigate elsewhere').
action_type(maintain_confidentiality).
action_label(maintain_confidentiality, 'Maintain confidentiality').
action_type(maintain_contract_conditions).
action_label(maintain_contract_conditions, 'Maintain contract conditions').
action_type(maintain_data_operations_record).
action_label(maintain_data_operations_record, 'Maintain Data Operations Record').
action_type(maintain_habilitation_conditions).
action_label(maintain_habilitation_conditions, 'Maintain habilitation conditions').
action_type(maintain_integrity_in_public_private_relations).
action_label(maintain_integrity_in_public_private_relations, 'Maintain integrity').
action_type(make_payments_to_contratado).
action_label(make_payments_to_contratado, 'Make payments').
action_type(nao_afetar_condicoes_essenciais).
action_label(nao_afetar_condicoes_essenciais, 'Do not affect essential conditions').
action_type(nao_desnaturar_objeto).
action_label(nao_desnaturar_objeto, 'Do not change contract nature').
action_type(no_right_assign_contract).
action_label(no_right_assign_contract, 'No right to assign contract').
action_type(no_right_assign_credit).
action_label(no_right_assign_credit, 'No right to assign credit').
action_type(no_right_issue_credit_title).
action_label(no_right_issue_credit_title, 'No right to issue credit title').
action_type(no_right_subcontract).
action_label(no_right_subcontract, 'No right to subcontract').
action_type(no_right_to_celebrate_additives).
action_label(no_right_to_celebrate_additives, 'No right to celebrate additives').
action_type(not_offer_undue_advantage).
action_label(not_offer_undue_advantage, 'Not offer undue advantage').
action_type(notify_bndes_of_irregularities).
action_label(notify_bndes_of_irregularities, 'Notify BNDES').
action_type(notify_of_breach_and_allow_cure).
action_label(notify_of_breach_and_allow_cure, 'Notify of breach and allow cure').
action_type(notify_penalty_impediment).
action_label(notify_penalty_impediment, 'Notify penalty impediment').
action_type(notify_unauthorized_information_use).
action_label(notify_unauthorized_information_use, 'Notify unauthorized information use').
action_type(obey_instructions).
action_label(obey_instructions, 'Obey instructions').
action_type(observe_bndes_policies).
action_label(observe_bndes_policies, 'Observe BNDES policies').
action_type(obtain_consent).
action_label(obtain_consent, 'Obtain consent').
action_type(obtain_guarantor_consent).
action_label(obtain_guarantor_consent, 'Obtain guarantor consent').
action_type(obtain_new_guarantee).
action_label(obtain_new_guarantee, 'Obtain new guarantee').
action_type(omit_access_to_confidential_info).
action_label(omit_access_to_confidential_info, 'Omit access to confidential info').
action_type(omit_celebration_of_additives).
action_label(omit_celebration_of_additives, 'Omit celebration of additives').
action_type(omit_contract_assignment).
action_label(omit_contract_assignment, 'Omit contract assignment').
action_type(omit_credit_assignment).
action_label(omit_credit_assignment, 'Omit credit assignment').
action_type(omit_illegal_acts).
action_label(omit_illegal_acts, 'Omit illegal acts').
action_type(omit_improper_data_use).
action_label(omit_improper_data_use, 'Omit improper data use').
action_type(omit_issuing_credit_title).
action_label(omit_issuing_credit_title, 'Omit issuing credit title').
action_type(omit_subcontracting).
action_label(omit_subcontracting, 'Omit subcontracting').
action_type(omitir_pagamento).
action_label(omitir_pagamento, 'Omit payment if requirements not met').
action_type(oust_agents_involved_in_irregularities).
action_label(oust_agents_involved_in_irregularities, 'Oust agents').
action_type(pay_all_charges_and_taxes).
action_label(pay_all_charges_and_taxes, 'Pay all charges and taxes').
action_type(present_dif).
action_label(present_dif, 'Present DIF').
action_type(prevent_allocation_of_relatives).
action_label(prevent_allocation_of_relatives, 'Prevent relative allocation').
action_type(prevent_contract_suspension).
action_label(prevent_contract_suspension, 'Prevent contract suspension').
action_type(prevent_favorecimento).
action_label(prevent_favorecimento, 'Prevent favoritism').
action_type(promote_negotiation).
action_label(promote_negotiation, 'Promote negotiation').
action_type(prove_no_discriminatory_practices).
action_label(prove_no_discriminatory_practices, 'Prove no discriminatory practices').
action_type(provide_access_channel).
action_label(provide_access_channel, 'Provide Access Channel').
action_type(provide_clarifications).
action_label(provide_clarifications, 'Provide clarifications').
action_type(provide_contracted_party_with_ethics_code).
action_label(provide_contracted_party_with_ethics_code, 'Provide access to ethics code').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_exclusion_from_simples_nacional).
action_label(provide_exclusion_from_simples_nacional, 'Provide exclusion from Simples Nacional').
action_type(provide_necessary_information).
action_label(provide_necessary_information, 'Provide necessary information').
action_type(provide_written_notice_of_termination).
action_label(provide_written_notice_of_termination, 'Provide written notice of termination').
action_type(receive_necessary_information).
action_label(receive_necessary_information, 'Receive necessary information').
action_type(receive_notebooks).
action_label(receive_notebooks, 'Receive notebooks').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payments_from_bndes).
action_label(receive_payments_from_bndes, 'Receive payments').
action_type(repair_contract_object).
action_label(repair_contract_object, 'Repair contract object').
action_type(repair_damages_to_bndes_or_third_parties).
action_label(repair_damages_to_bndes_or_third_parties, 'Repair damages to BNDES or third parties').
action_type(report_irregularity).
action_label(report_irregularity, 'Report irregularity').
action_type(request_bndes_ethics_code).
action_label(request_bndes_ethics_code, 'Request BNDES ethics code').
action_type(request_confidentiality_agreements).
action_label(request_confidentiality_agreements, 'Request confidentiality agreements').
action_type(request_extension_for_guarantee).
action_label(request_extension_for_guarantee, 'Request guarantee extension').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_price_revision_after_deadline).
action_label(request_price_revision_after_deadline, 'No right to request after deadline').
action_type(request_price_revision_before_end).
action_label(request_price_revision_before_end, 'Request price revision before end').
action_type(request_proof_habilitation).
action_label(request_proof_habilitation, 'Request proof of habilitation').
action_type(request_proof_of_no_discriminatory_practices).
action_label(request_proof_of_no_discriminatory_practices, 'Request proof of no discrimination').
action_type(resolve_disputes_in_rio).
action_label(resolve_disputes_in_rio, 'Resolve disputes in Rio de Janeiro').
action_type(respond_for_professional_expenses).
action_label(respond_for_professional_expenses, 'Respond for professional expenses').
action_type(responder_por_danos).
action_label(responder_por_danos, 'Be liable for damages').
action_type(ressarcir_se).
action_label(ressarcir_se, 'Be reimbursed').
action_type(return_documents).
action_label(return_documents, 'Return documents').
action_type(return_resources).
action_label(return_resources, 'Return resources').
action_type(revise_prices).
action_label(revise_prices, 'Revise prices').
action_type(right_of_recourse).
action_label(right_of_recourse, 'Right of Recourse').
action_type(right_to_act_under_contract_for_6_months).
action_label(right_to_act_under_contract_for_6_months, 'Right to act under contract for 6 months').
action_type(sign_confidentiality_agreements).
action_label(sign_confidentiality_agreements, 'Sign confidentiality agreements').
action_type(solve_defects).
action_label(solve_defects, 'Solve defects').
action_type(subject_to_penalties).
action_label(subject_to_penalties, 'Subject to penalties').
action_type(supply_notebooks).
action_label(supply_notebooks, 'Supply notebooks').
action_type(suspend_contract_execution).
action_label(suspend_contract_execution, 'Suspend contract execution').
action_type(terminate_contract_cessao_descumprimento).
action_label(terminate_contract_cessao_descumprimento, 'Terminate cession violation').
action_type(terminate_contract_consensually).
action_label(terminate_contract_consensually, 'Terminate contract consensually').
action_type(terminate_contract_dissolution).
action_label(terminate_contract_dissolution, 'Terminate contract-dissolution').
action_type(terminate_contract_due_to_corruption).
action_label(terminate_contract_due_to_corruption, 'Terminate due to corruption').
action_type(terminate_contract_due_to_lack_of_release).
action_label(terminate_contract_due_to_lack_of_release, 'Terminate due to lack of release').
action_type(terminate_contract_for_breach).
action_label(terminate_contract_for_breach, 'Terminate contract for breach').
action_type(terminate_contract_force_majeure).
action_label(terminate_contract_force_majeure, 'Terminate force majeure').
action_type(terminate_contract_insolvency).
action_label(terminate_contract_insolvency, 'Terminate contract-insolvency').
action_type(terminate_contract_loss_qualification).
action_label(terminate_contract_loss_qualification, 'Terminate loss of qualification').
action_type(undertake_corporate_operations).
action_label(undertake_corporate_operations, 'Undertake corporate operations').
action_type(waive_rights_by_omission).
action_label(waive_rights_by_omission, 'No right to claim waiver').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_004_2023).
contract_metadata(contrato_ocs_004_2023, numero_sap, '4400005464').
contract_metadata(contrato_ocs_004_2023, partes, ['BANCO NACIONAL DE DESENVOLVIMENlrO ECONÔMICO E SOCIAL', 'DATEN TECNOLOGIA LTDA']).
contract_metadata(contrato_ocs_004_2023, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL - BNDES').
contract_metadata(contrato_ocs_004_2023, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_004_2023, contratado, 'DATEN TECNOLOGIA LTDA').
contract_metadata(contrato_ocs_004_2023, cnpj_contratado, '04.602.789/0001-01').
contract_metadata(contrato_ocs_004_2023, procedimento_licitatorio, 'Pregão Eletrônico nº 004/2023 - BNDES').
contract_metadata(contrato_ocs_004_2023, data_autorizacao, '24/03/2023').
contract_metadata_raw(contrato_ocs_004_2023, 'ip_ati_deset', '003/2023', 'trecho_literal').
contract_metadata_raw(contrato_ocs_004_2023, 'data_ip_ati_deset', '21 /03/2023', 'trecho_literal').
contract_metadata(contrato_ocs_004_2023, rubrica_orcamentaria, '1750100071').
contract_metadata(contrato_ocs_004_2023, centro_custo, 'BN30005000').
contract_metadata(contrato_ocs_004_2023, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_004_2023, regulamento, 'Regulamento Licitações e Contratos do Sistema BNDES').
contract_clause(contrato_ocs_004_2023, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA - OBJETO', 'O presente Contrato tem por objeto o fornecimento de computadores portáteis (notebooks), conforme especificações constantes do Termo de Referência (Anexo I do Edital do Pregão Eletrônico nº 004/2023 - BNDES) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e li deste Contrato.').
contract_clause(contrato_ocs_004_2023, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA - VIGÊNCIA', 'O presente Contrato terá duração de 6 (seis) meses, a contar da data de sua assinatura.').
contract_clause(contrato_ocs_004_2023, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA -LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Termo de Referência (Anexo I deste Contrato) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e li deste Contrato.').
contract_clause(contrato_ocs_004_2023, clausula_quarta_recebimento_objeto, 'CLÁUSULA QUARTA - RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através da Comissão de Recebimento mencionada na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo 1 (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_004_2023, clausula_quinta_garantia_dos_bens_fornecidos, 'CLÁUSULA QUINTA - GARANTIA DOS BENS FORNECIDOS', 'A garantia será de 36 (trinta e seis) meses, contados do recebimento definitivo dos bens em questão, salvo se a proposta (Anexo li deste Contrato) previr prazo maior, observado o disposto no Anexo 1 (Termo de Referência) deste Contrato. Parágrafo Primeiro A garantia ocorrerá sem nenhum ônus para o BNDES e será prestada sob responsabilidade do CONTRATADO, inclusive quando for necessário o transporte dos bens ou ainda o traslado e a hospedagem de técnicos do CONTRATADO ou qualquer outro tipo de serviço necessário para o cumprimento da garantia. Parágrafo Segundo O CONTRATADO deverá solucionar todos os vícios e defeitos apresentados pelos bens, dentro do período de garantia, no prazo de 5 (cinco) dias a contar da data da abertura do chamado ou da retirada do equipamento, podendo substitui-los por outros bens, novos e perfeitos, que atendam às mesmas especificações estipuladas neste Contrato e em seus Anexos, no mesmo prazo para o conserto.').
contract_clause(contrato_ocs_004_2023, clausula_sexta_preco, 'CLÁUSULA SEXTA - PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de até R$ 1.962.115,02 (um milhão e novecentos e sessenta e dois mil e cento e quinze reais e dois centavos), conforme proposta apresentada (Anexo li deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento: Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato. Parágrafo Segundo Na hipótese de o objeto ser parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis. Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização ao CONTRATADO. Parágrafo Quarto O CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua proposta, devendo, conforme o caso: 1. complementá-los, caso os quantitativos previstos inicialmente em sua proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato; ou li. reverter o excedente como lucro, sendo facultada ao BNDES a promoção de negociação com vistas a eventual prorrogação contratual.').
contract_clause(contrato_ocs_004_2023, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA - PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, em parcela única, por meio de crédito em conta bancária, em até 10 (dez) dias úteis a contar da data de apresentação do documento fiscal ou equivalente legal (prioritariamente nota fiscal, e nos casos de dispensa da nota fiscal: fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTIRATADO, observado o disposto no Anexo 1 (Termo de Referência) deste Instrumento. Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo - ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir - possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte do fornecimento do bem. Parágrafo Segundo A apresentação do documento de cobrança fora do prazo previsto nesta cláusula poderá implicar em sua rejeição e no direito do BNDES se ressarcir, preferencialmente, mediante desconto do valor a ser pago ao CONTRATADO, por qualquer penalidade tributária incidente pelo atraso. Parágrafo Terceiro Nas hipóteses em que o recebimento definitivo ocorrer após a entrega do documento fiscal ou equivalente legal, o BNDES terá até 10 (dez) dias úteis, a contar da data em que o objeto tiver sido recebido definitivamente, para efetuar o pagamento. Parágrafo Quarto Para toda efetivação de pagamento, o Contratado deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica ou protocolar em sistema eletrônico próprio do BNDES, considerando as orientações do Contratante vigentes na ocasião do pagamento. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento. Parágrafo Quinto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: 1. número da Ordem de Compra/Serviço - OCS; li. número SAP do Contrato; Ili. número do pedido SAP, a ser informado pelo Gestor do Cointrato; IV. descrição detalhada do objeto executado e dos respectivos valores; V. período de referência da execução do objeto; VI. nome e número do [CNPJ] do CONTRATADO, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; VIII. nome e número do banco e da agência, bem como o número da conta corrente do CONTRATADO, vinculada ao [CNPJ] constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; IX. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social -BNDES; X. CNPJ do tomador do serviço: 33.657.248/0001 -89; XI. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caiso; XII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento - DIF; XIII. número de inscrição do contribuinte individual válido junto ao INSS (NIT ou PIS/PASEP); e XIV.destaque das retenções tributárias aplicáveis, conforme estabelecido na DIF. Parágrafo Sexto Os pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pelo CONTRATADO. Em casos de dispensa ou benefício fiscal que implique em redução ou eliminação da retenção de tributos, o CONTRATADO fornecerá todos os documentos comprobatórios. Parágrafo Sétimo Caso o CONTRATADO emita documento fiscal ou equivalente legal autorizado por Estado diferente daquele onde se localiza o estabelecimento do BNDES adquirente do bem e destinatário da cobrança, deverá considerar a condição de não contribuinte do BNDES na emissão da nota fiscal e no recolhimento do diferencial de alíquota do ICMS, se houver. Parágrafo Oitavo O documento fiscal ou equivalente legal emitido pelo CONTRA'TADO deverá estar em conformidade com a legislação do Estado onde o CONTRATADO esteja estabelecida, cuja regularidade fiscal foi avaliada na etapa de habilitaçào, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos, sob pena de devolução do documento e interrupção do prazo para pagamento. Parágrafo Nono Ao documento fiscal ou equivalente legal deverão ser anexados: 1. certidões de regularidade fiscal exigidas na fase de habilitação; li. comprovante de que o CONTRATADO é optante do Simples Nacional, se for o caso; Ili. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; e IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado. Parágrafo Décimo Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADO ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES. Parágrafo Décimo Primeiro Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pelo CONTRATADO. Parágrafo Décimo Segundo Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro r.ata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação. Parágrafo Décimo Terceiro Fica assegurado ao BNDES o direito de deduzir do pagamento devido ao CONTRATADO, por força deste Contrato ou de outro contrato mantido com o BNDES, o valor correspondente aos pagamentos efetuados a maior ou em duplicidade.').
contract_clause(contrato_ocs_004_2023, clausula_oitava_equilibrio_economico_financeiiflo_contrato, 'CLÁUSULA OITAVA- EQUILÍBRIO ECONÔMICO-FINANCEIIFlO DO CONTRATO Considerando o prazo de vigência do presente Contrato, não se admite reajuste ou repactuação de preços, devendo o CONTRATADO arcar com eventuais elevações dos custos decorrentes de fatores ordinários, tais como alterações de acordo ou convenção coletiva de trabalho. Parágrafo Primeiro O BNDES e o CONTRATADO têm direito à revisão de preços, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, desde que ocorra fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: 1. a revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO. Neste último caso, o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; li. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta e do momento do pedido da revisão; e Ili. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ie o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado. Parágrafo Segundo O CONTRATADO deverá solicitar a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: 1. caso o fato gerador da revisão de preços ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador, para solicitar a revisão de preços; li. o BNDES deverá analisar o pedido de revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e Ili. caso o CONTRATADO não solicite a revisão de preços nos prazos fixados acima, não fará jus à mesma, operando-se a renúncia ao seu eventual direito.', 'CLÁUSULA OITAVA- EQUILÍBRIO ECONÔMICO-FINANCEIIFlO DO CONTRATO Considerando o prazo de vigência do presente Contrato, não se admite reajuste ou repactuação de preços, devendo o CONTRATADO arcar com eventuais elevações dos custos decorrentes de fatores ordinários, tais como alterações de acordo ou convenção coletiva de trabalho. Parágrafo Primeiro O BNDES e o CONTRATADO têm direito à revisão de preços, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, desde que ocorra fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: 1. a revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO. Neste último caso, o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; li. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta e do momento do pedido da revisão; e Ili. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ie o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado. Parágrafo Segundo O CONTRATADO deverá solicitar a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: 1. caso o fato gerador da revisão de preços ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador, para solicitar a revisão de preços; li. o BNDES deverá analisar o pedido de revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e Ili. caso o CONTRATADO não solicite a revisão de preços nos prazos fixados acima, não fará jus à mesma, operando-se a renúncia ao seu eventual direito.').
contract_clause(contrato_ocs_004_2023, clausula_nona_matriz_riscos, 'CLÁUSULA NONA - MATRIZ DE RISCOS O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior ca1Pacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo 111 deste Contrato. Parágrafo Primeiro É vedada a celebração de aditivos decorrentes de eventos supe1Nenientes alocados, na Matriz de Riscos, como de responsabilidade do CONTRATADO.', 'CLÁUSULA NONA - MATRIZ DE RISCOS O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior ca1Pacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo 111 deste Contrato. Parágrafo Primeiro É vedada a celebração de aditivos decorrentes de eventos supe1Nenientes alocados, na Matriz de Riscos, como de responsabilidade do CONTRATADO.').
contract_clause(contrato_ocs_004_2023, clausula_decima_garantia_contratual, 'CLÁUSULA DÉCIMA - GARANTIA CONTRATUAL O CONTRATADO prestará, no prazo de até 1 O ( dez) dias úteis, contados da convocação, garantia contratual, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 98.105,751 (noventa e oito mil e cento e cinco reais e setenta e cinco centavos), que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. 1. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocaçào; li. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas ao CONTRATADO; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO -ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. Ili. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO -ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes. Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES. Parágrafo Segundo Havendo majoração do preço contratado, decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, fica dispensada a atualização da garantia, salvo se o valor da atualização for igual ou superior ao patamar referenciado no inciso li do artigo 91 do Regulamento de Liciitações e Contratos do SISTEMA BNDES. Parágrafo Terceiro Nos demais casos que demandem a complementação ou renovação da garantia, tais como alteração do objeto (aditivo quantitativo ou qualitativo), prorrogação contratual, dentre outros, o CONTRATADO deverá providenciá-la no prazo estipulado pelo BNDES. Parágrafo Quarto Sempre que o contrato for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao COI\ITRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.', 'CLÁUSULA DÉCIMA - GARANTIA CONTRATUAL O CONTRATADO prestará, no prazo de até 1 O ( dez) dias úteis, contados da convocação, garantia contratual, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 98.105,751 (noventa e oito mil e cento e cinco reais e setenta e cinco centavos), que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. 1. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocaçào; li. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas ao CONTRATADO; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO -ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. Ili. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO -ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes. Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES. Parágrafo Segundo Havendo majoração do preço contratado, decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, fica dispensada a atualização da garantia, salvo se o valor da atualização for igual ou superior ao patamar referenciado no inciso li do artigo 91 do Regulamento de Liciitações e Contratos do SISTEMA BNDES. Parágrafo Terceiro Nos demais casos que demandem a complementação ou renovação da garantia, tais como alteração do objeto (aditivo quantitativo ou qualitativo), prorrogação contratual, dentre outros, o CONTRATADO deverá providenciá-la no prazo estipulado pelo BNDES. Parágrafo Quarto Sempre que o contrato for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao COI\ITRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.').
contract_clause(contrato_ocs_004_2023, clausula_decima_primeira_obrigações_contratado, 'CLÁUSULA DÉCIMA PRIMEIRA - OBRIGAÇÕES DO CONTRtATADO', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: 1. manter durante a vigência deste Contrato todas as condiçôes de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; li. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; Ili. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que venha a emitir em desacordo com a legislação aplicável. VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; XI. responder, em relação aos seus profissionais, por todas as despesas decorrentes da execução dos serviços, tais como: salários, seguros de acidente, taxas, impostos, contribuições, indenizações, vales-refeição, vales-transportes e outras que porventura venham a ser criadas e exigidas pelo Poder Público ou no instrumento coletivo da categoria.; XII. apresentar, em até 1 O dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento -DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; XIII. assumir inteira responsabilidade técnica e administrativa em relação ao objeto contratado, não podendo, sob qualquer hipótese, transferir a terceiros a responsabilidade por problemas ou falhas, não estando vedada a continuidade do Contrato se sobrevier regular reorganização societária, tal como cisão, incorporação ou fusão; XIV. atender prontamente quaisquer exigências do representante do BNDES, no que diz respeito às suas necessidades. XV. prestar todos os esclarecimentos que lhe forem solicitados pelo BNDES. XVI. notificar prontamente ao BNDES qualquer divulgação ou uso não autorizado de informações que porventura tomar conhecimento, adotando todas as medidas recomendadas pelo BNDES para remediar qualquer divulgação ou uso. XVII. informar ao BNDES toda e qualquer irregularidade observada no curso da execução contratual. Não usar, copiar, duplicar ou de alguma outra forma reproduzir ou reter todas ou quaisquer informações do BNDES, exceto se autorizada previamente, por escrito, pelo BNDES. Não efetuar a compilação reversa, montagem reversa ou engenharia reversa de qualquer programa aplicativo do BNDES ou de terceiros a que venha ter acesso por força do serviço. XVIII. identificar seus funcionários com crachás da empresa e informar os horários em que estes efetuarão os serviços no BNDES; XIX. devolver, impreterivelmente, ao término do Contrato, ou a qualquer tempo a pedido do BNDES, todos os documentos que o BNDES o tenha fornecido. XX. devolver ao final do Contrato recursos fornecidos pelo BNDES sob pena de indenização dos danificados ou perdidos; XXI. adotar, sempre que cabível, na execução do Contrato, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição; responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos seus profissionais alocados na execução do Contrato, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES; XXIII. cumprir, durante a execução do Contrato, as leis federais, estaduais e municipais vigentes ou que entrarem em vigor, sendo a única responsável pelas infrações cometidas, convencionando-se, desde já, que o BNDES poderá. descontar de qualquer crédito da Contratada a importância correspondente a eventuais pagamentos desta natureza que venha efetuar por imposição legal; e').
contract_clause(contrato_ocs_004_2023, clausula_decima_segunda_conduta_etica_contratado_bndes, 'CLÁUSULA DÉCIMA SEGUNDA -CONDUTA ÉTICA DO CONTRATADO E DO BNDES', 'O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental. Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o COINTRATADO obriga-se, inclusive, a: 1. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; li. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; Ili. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar a Política para Transações com Partes Relacionadas e o Código de Ética do Sistema BNDES vigentes ao tempo da contratação, bem como a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de reduçáo da poluição. Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção. Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos li e Ili do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé. Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato. Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.qov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro - RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_004_2023, clausula_decima_terceira_sigilo_informacões, 'CLÁUSULA DÉCIMA TERCEIRA - SIGILO DAS INFORMAÇÔES', 'Caso o CONTRATADO venha a ter acesso a dados, materiais, documentos e informações de natureza sigilosa, direta ou indiretamente, em decorrência da execução do objeto contratual, deverá manter o sigilo dos mesmos, bem como orientar os profissionais envolvidos a cumprir esta obrigação, respeitando-se as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES. Parágrafo Único Assim que solicitado pelo Gestor do Contrato, o CONTRATADO deverá providenciar a assinatura, por seu representante legal e pelos profissionais que tiverem acesso a informações sigilosas, dos Termos de Confidencialidade a serem disponibilizados pelo BNDES.').
contract_clause(contrato_ocs_004_2023, clausula_decima_quarta_acesso_protecao_dados_pessoais, 'CLÁUSULA DÉCIMA QUARTA - ACESSO E PROTEÇÃO DE DADOS PESSOAIS As partes assumem o compromisso de proteger os direitos fundamentais de liberdade e de privacidade, relativos ao tratamento de dados pessoais, nos meios físicos e digitais, devendo, para tanto, adotar medidas corretas de segurança :sob o aspecto técnico, jurídico e administrativo, e observar que: !.Eventual tratamento de dados em razão do presente Contrato deverá ser realizado conforme os parâmetros previstos na legislação, especialmente na Lei nº 13. 709/2018 - Lei Geral de Proteção de Dados - LGPD, dentro de propósitos legítimos, específicos, explícitos e informados ao titular; li.O tratamento será limitado às atividades necessárias ao atin~Jimento das finalidades contratuais e, caso seja necessário, ao cumprimento de suas obrigações legais ou regulatórias, sejam de ordem principal ou acessória, observando-se que, em caso de necessidade de coleta de dados pessoais, esta será realizada mediante prévia aprovação do BNDES, responsabilizando-se o CONTA.ATADO por obter o consentimento dos titulares, salvo nos casos em que a legislação dispense tal medida; Ili.O CONTRATADO deverá seguir as instruções recebidas do BNDES em relação ao tratamento de dados pessoais; IV.O CONTRATADO se responsabilizará como "Controlador de dados" no caso do tratamento de dados para o cumprimento de suas obrigações legais ou regulatórias, devendo obedecer aos parâmetros previstos na legislação; V.Os dados coletados somente poderão ser utilizados pelas partes, seus representantes, empregados e prestadores de serviços diretamente alocados na execução contratual, sendo que, em hipótese alguma, poderão ser compartilhados ou utilizados para outros fins, sem a prévia autorização do BNDES, ou caso haja alguma ordem judicial, observando-se as medidas legalmente previstas para tanto; VI.O CONTRATADO deve manter a confidencialidade dos dados pessoais obtidos em razão do presente contrato, devendo adotar as medidas técnicas e administrativas adequadas e necessárias, visando assegurar a proteção dos dados, nos termos do artigo 46 da LGPD, de modo a garantir um nível apropriado de segurança e a prevenção e mitigação de eventuais riscos; VII.Os dados deverão ser armazenados de maneira segura pelo CONTRATADO, que utilizará recursos de segurança da informação e tecnologia adequados, inclusive quanto a mecanismos de detecção e prevenção de ataques ciibernéticos e incidentes de segurança da informação. VIII.O CONTRATADO dará conhecimento formal para seus empregados e/ou prestadores de serviço acerca das disposições previstas nesta Cláusula e na Cláusula de Sigilo das Informações, responsabilizando-se por eventual uso indevido dos dados pessoais, bem como por quaisquer falhas nos sistemas por ela empregados para o tratamento dos dados. IX.O BNDES possui direito de regresso em face do CONTRtATADO em razão de eventuais danos causados por este em decorrência do descumprimento das responsabilidades e obrigações previstas no âmbito deste contrato e da Lei Geral de Proteção de Dados Pessoais; X.O CONTRATADO deverá disponibilizar ao titular do dado um canal ou sistema em que seja garantida consulta facilitada e gratuita sobre a forma, a duração do tratamento e a integralidade de seus dados pessoais. XI.O CONTRATADO deverá informar imediatamente ao BNDES todas as solicitações recebidas em razão do exercício dos direitos pelo titular dos dados relacionados a este Contrato, seguindo as orientações fixadas pelo BNDES e pela legislação em vigor para o adequado endereçamento das demandas. XII.O CONTRATADO deverá manter registro de todas as operações de tratamento de dados pessoais que realizar no âmbito do Contrato disponiibilizando, sempre que solicitado pelo BNDES, as informações necessárias à produção do Relatório de Impacto de Dados Pessoais, disposto no artigo 5º, XVII , da Lei Geral de Proteção de Dados Pessoais. XIII.Qualquer incidente que implique em violação ou risco de violação ou vazamento de dados pessoais deverá ser prontamente comunicado ao BNDES, informando-se também todas as providências adotadas e os dados pessoais eventualmente afetados, cabendo ao CONTRATADO disponibilizar as informações e documentos solicitados e colaborar com qualquer investigação ou auditoria que venha a ser realizada. XIV.Ao final da vigência do Contrato, o CONTRATADO deverá eliminar de sua base de informações todo e qualquer dado pessoal que tenha tido acesso em razão da execução do objeto contratado, salvo quando tenha que manter a informação para o cumprimento de obrigação legal. Parágrafo Primeiro As Partes reconhecem que, se durante a execução do Contrato armazenarem, coletarem, tratarem ou de qualquer outra forma processarem dados pessoais, no sentido dado pela legislação vigente aplicável, o BNDES será considerado "Controlador de Dados", e o CONTRATADO "Operador" ou "Processador de Dados", salvo nas situações expressas em contrário nesse Contrato. Contudo, caso o CONTRATADO descumpra as obrigações prevista na legislação de proteção de dados ou as instruções do BNDES, será equiparado a "Controlador de Dados", inclusive para fins de sua responsabilização por eventuais danos causados. Parágrafo Segundo Caso o CONTRATADO disponibilize dados de terceiros, além das obrigações no caput desta Cláusula, deve se responsabilizar por eventuais danos que o BNDES venha a sofrer em decorrência de uso indevido de dados pessoais por parte do CONTRATADO, sempre que ficar comprovado que houve falha de segurança técnica e administrativa, descumprimento de regras previstas na legislação de proteção à privacidade e dados pessoais, e das orientações do BNDES, sem prejuízo das penalidades deste contrato. Parágrafo Terceiro A transferência internacional de dados deve se dar em caráter excepcional e na estrita observância da legislação, especialmente, dos artigos 33 a 36 da Lei nº 13.709/2018 e nos normativos do Banco Central do Brasil relativos ao processamento e armazenamento de dados das instituições financeiras, e dependerá de autorização prévia do BNDES ao CONTRATADO. Parágrafo Quarto A assinatura deste Contrato importa na manifestação de inequívoco consentimento do titular, seja ele pessoa física direta ou indiretamente relacionada ao CONTRATADO, inclusive sócios, representantes legais, empregados, contratados e/ou terceirizados, quando for o caso, dos dados pessoais que tenham se tornados públicos como condição para participação na licitação e para contratação, para tratamento pelo BNDES, na forma da Lei nº 13.709/2018. Poderão ser solicitados pelo BNDES dados pessoais adicionais a fim de viabilizar o cumprimento de obrigação legal. Parágrafo Quinto Os representantes legais signatários do presente autorizam a divulgação dos dados pessoais expressamente contidos nos documentos decorrentes do procedimento de licitação, tais como nome, CPF, e-mail, telefone e cargo, para fins de publicidade das contratações administrativas no site institucional do BNDES e em cumprimento à Lei nº 12.527/ 2011 (Lei de Acesso à Informação). Parágrafo Sexto As partes comprometem-se a coletar o consentimento, quando necessário, conforme previsto na Lei no 13.709/2018 (Lei Geral de Proteção de Dados - LGPD), bem como informar os titulares dos dados pessoais mencionados no presente instrumento, para as finalidades descritas no parágrafo acima.', 'trecho_literal').
contract_clause(contrato_ocs_004_2023, clausula_decima_quinta_obrigações_bndes, 'CLÁUSULA DÉCIMA QUINTA - OBRIGAÇÕES DO BNDES Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: 1. realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato; li. designar, como Gestor do Contrato, Flávia Tacques do Rego Monteiro, que atualmente exerce a função de Gerente da ATI/DESET/GEAT, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; Ili. designar, como substituto do Gestor do Contrato, para atuar em sua eventual ausência, quem estiver substituindo na função de gerente; IV. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita ao CONTRATADO; V. designar a Comissão de Recebimento, a quem caberá o recebimento do objeto, em conjunto com o Gestor do Contrato; VI. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, acesso ao Código de Ética do Sistema BNDES, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VII. colocar à disposição do CONTRATADO todas as informações necessárias ao perfeito fornecimento dos bens objeto deste Contrato; e VIII. comunicar ao CONTRATADO, por escrito: a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e e) a aplicação de eventual penalidade, nos termos deste Contrato.', 'trecho_literal').
contract_clause(contrato_ocs_004_2023, clausula_decima_sexta_equidade_genero_valorizacao_diversidade, 'CLÁUSULA DÉCIMA SEXTA -EQUIDADE DE GÊNERO IE VALORIZAÇÃO DA DIVERSIDADE O CONTRATADO deverá comprovar, sempre que solicitado pelo BNDES, a inexistência de decisão administrativa final sancionadora, exarada por autoridade ou órgão competente, em razão da prática de atos, pelo próprio CONTBATADO ou dirigentes, administradores ou sócios majoritários, que importem em discriminação de raça ou gênero, trabalho infantil ou trabalho escravo, e de sentença condenatória transitada em julgado, proferida em decorrência dos referidos atos, e, se for o caso, de outros que caracterizem assédio moral ou sexual e importem em crime contra o meio ambiente. Parágrafo Primeiro Na hipótese de ter havido decisão administrativa e/ou sentença condenatória, nos termos referidos no caput desta Cláusula, a execução do objeto contratual poderá ser suspensa pelo BNDES até a comprovação do cumprimento da reparação imposta ou da reabilitação do CONTRATADO ou de seus dirigentes, conforme o caso. Parágrafo Segundo A comprovação a que se refere o caput desta Cláusula será realizada por meio de declaração, sem prejuízo da verificação do sistema informativo interno do BNDES -Sistema de Gerenciamento do Cadastro de Entidades (N02), acerca da inexistência de sanção em face do CONTRATADO e/ou de seus dirigentes, administradores ou sócios majoritários que impeça a contratação.', 'trecho_literal').
contract_clause(contrato_ocs_004_2023, clausula_decima_setima_cessão_contrato_credito_sucessão_subcontratação, 'CLÁUSULA DÉCIMA SÉTIMA -CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo. Parágrafo Primeiro É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: 1. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e li. manutenção de todas as condições contratuais e requisitos de habilitação originais. Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes. Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.', 'trecho_literal').
contract_clause(contrato_ocs_004_2023, clausula_decima_oitava_penalidades, 'CLÁUSULA DÉCIMA OITAVA- PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: 1. advertência; li. multa, de acordo com o Anexo 1 (Termo de Referência); e Ili. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração. Parágrafo Primeiro As penalidades serão aplicadas observadas as normas do Regulamento de Licitações e Contratos das Empresas Integrantes do SISTEMA BNDES. Parágrafo Segundo Contra a decisão de aplicação de penalidade, o CONTRATADO poderá requerer a reconsideração para a decisão de advertência, ou interpor o recurso cabível para as demais penalidades, na forma e no prazo previstos no Regulamento de Licitações e Contratos do SISTEMA BNDES. Parágrafo Terceiro A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato. Parágrafo Quarto A multa poderá ser aplicada juntamente com as demais penalidades. Parágrafo Quinto A multa aplicada ao CONTRATADO e os preJu1zos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos. Parágrafo Sexto No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013. Parágrafo Sétimo A celebração de Termo de Ajustamento de Conduta prevista no Regulamento de Licitações e Contratos do Sistema BNDES não importa em renúncia às penalidades prevista neste Contrato e no Anexo 1 (Termo de Referência). Parágrafo Oitavo A sanção prevista no inciso Ili desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: 1. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; li. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; Ili. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_004_2023, clausula_decima_nona_alteracoes_contratuais, 'CLÁUSULA DÉCIMA NONA - ALTERAÇÕES CONTRATUAIS', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que: 1. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e li. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato). Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar. Parágrafo Segundo A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente. Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento, os ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato e alterações de preços decorrentes decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, que poderão ser celebrados por meio epistolar.').
contract_clause(contrato_ocs_004_2023, clausula_vigésima_extincao_contrato, 'CLÁUSULA VIGÉSIMA- EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, e ainda: 1. Consensualmente, formalizada em autorização escrita e fundamentada do BNDES, mediante aviso prévio por escrito, com antecedência mínima de 90 (noventa) dias ou de prazo menor a ser negociado pelas partes à época da rescisão; li. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; li. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; Ili. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 ( cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo; IV. quando for decretada a falência do CONTRATADO; V. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VI. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. caso o CONTRATADO seja declarada inidônea pela Uniüo, por Estado ou pelo Distrito Federal; VIII. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; IX. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual ; X. em razão da dissolução do CONTRATADO; XI. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato. Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias. Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_004_2023, clausula_vigésima_primeira_disposicoes_finais, 'CLÁUSULA VIGÉSIMA PRIMEIRA - DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto. Parágrafo Primeiro Integram o presente Contrato: Anexo 1 - Termo de Referência do Pregão Eletrônico nº 004/20213 - BNDES Anexo 11 - Proposta Anexo 111 - Matriz de Risco Anexo IV - Termo de Confidencialidade para Representante Le~1al Anexo V - Termo de Confidencialidade para Profissionais Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou negação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_004_2023, clausula_vigésima_segunda_foro, 'CLÁUSULA VIGÉSIMA SEGUNDA - FORO', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja. As partes consideram, para todos os efeitos, a data da última assinatura digital como a data de formalização jurídica deste instrumento. As folhas deste contrato foram conferidas por Márcio Oliveira ela Rocha, advogado do BNDES, por autorização do representante legal que o assina. BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL - BNDES DATEN TECNOLOGIA L TDA Testemunhas:').

% ===== END =====
