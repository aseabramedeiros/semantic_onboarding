% ===== KOA Combined Output | contract_id: contrato_ocs_167_2023 =====

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
% UFO-only grounding generated from: KOA_Contrato_OCS_167_2023_-_BTV_notebooks_Positivo.pl
% contract_id: contrato_ocs_167_2023

instance_of(contrato_ocs_167_2023, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(tyco_servicos_de_comercio_de_informatica_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_167_2023).
plays_role(tyco_servicos_de_comercio_de_informatica_ltda, hired_service_provider_role, contrato_ocs_167_2023).

clause_of(clausula_primeira_objeto, contrato_ocs_167_2023).
clause_of(clausula_segunda_vigencia, contrato_ocs_167_2023).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_167_2023).
clause_of(clausula_quarta_recebimento_objeto, contrato_ocs_167_2023).
clause_of(clausula_quinta_garantia_dos_bens_fornecidos, contrato_ocs_167_2023).
clause_of(clausula_sexta_preco, contrato_ocs_167_2023).
clause_of(clausula_setima_pagamento, contrato_ocs_167_2023).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_167_2023).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_167_2023).
clause_of(clausula_decima_garantia_contratual, contrato_ocs_167_2023).
clause_of(clausula_decima_primeira_obrigações_contratado, contrato_ocs_167_2023).
clause_of(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, contrato_ocs_167_2023).
clause_of(clausula_decima_terceira_sigilo_das_informações, contrato_ocs_167_2023).
clause_of(clausula_decima_oitava_penalidades, contrato_ocs_167_2023).
clause_of(clausula_decima_nona_alterações_contratuais, contrato_ocs_167_2023).
clause_of(clausula_vigésima_extinção_contrato, contrato_ocs_167_2023).
clause_of(clausula_vigésima_primeira_disposições_finais, contrato_ocs_167_2023).
clause_of(clausula_vigésima_segunda_foro, contrato_ocs_167_2023).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, provide_notebooks).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_notebooks).
legal_relation_instance(clausula_segunda_vigencia, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_contract_duration).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, execute_contract_object).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_execution).
legal_relation_instance(clausula_quarta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_quarta_recebimento_objeto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_quinta_garantia_dos_bens_fornecidos, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, provide_warranty_for_goods).
legal_relation_instance(clausula_quinta_garantia_dos_bens_fornecidos, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_goods_warranty).
legal_relation_instance(clausula_quinta_garantia_dos_bens_fornecidos, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, solve_defects).
legal_relation_instance(clausula_quinta_garantia_dos_bens_fornecidos, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, solve_defects_in_5_days).
legal_relation_instance(clausula_quinta_garantia_dos_bens_fornecidos, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, replace_defective_goods).
legal_relation_instance(clausula_quinta_garantia_dos_bens_fornecidos, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, have_defective_goods_replaced).
legal_relation_instance(clausula_sexta_preco, no_right_to_action, tyco_servicos_de_comercio_de_informatica_ltda, demand_indemnification).
legal_relation_instance(clausula_sexta_preco, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, bear_burden_quantification_error).
legal_relation_instance(clausula_sexta_preco, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, execute_contract_object).
legal_relation_instance(clausula_sexta_preco, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_payment_for_execution).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_party).
legal_relation_instance(clausula_setima_pagamento, right_to_action, tyco_servicos_de_comercio_de_informatica_ltda, receive_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, present_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, send_document_digitally).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, include_required_information).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, provide_supporting_documents).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reject_out_of_time_document).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_penalty_from_payment).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_payments).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, review_prices).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, tyco_servicos_de_comercio_de_informatica_ltda, request_price_review).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, request_price_review_before_contract_end).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, disability, tyco_servicos_de_comercio_de_informatica_ltda, cannot_request_price_review_after_contract_end).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_price_revision_request).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_omit, tyco_servicos_de_comercio_de_informatica_ltda, omit_celebration_additives).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, tyco_servicos_de_comercio_de_informatica_ltda, no_right_celebrate_additives).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, obtain_guarantor_consent).
legal_relation_instance(clausula_decima_garantia_contratual, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extend_guarantee_presentation_period).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, obtain_new_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, summon_contracted_party_to_provide_guarantee).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, maintain_qualification_conditions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, communicate_penalty_imposition).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, repair_object_of_contract).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, repair_damages).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, pay_charges_and_taxes).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, assume_responsibility_for_tax_documents).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, exclude_from_simples_nacional).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, allow_inspections).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, obey_instructions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, appoint_representative).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, maintain_integrity_public_private_relations).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, act_in_good_faith).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, act_according_to_principles).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, prevent_favoritism).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, prevent_allocation_of_family).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, remove_agents_causing_impediments).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, communicate_facts_to_bndes).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, maintain_integrity_public_private_relations_bndes).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, act_in_good_faith_bndes).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, act_according_to_principles_bndes).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informações, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, maintain_confidentiality).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informações, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, provide_signed_confidentiality_terms).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informações, duty_to_act, tyco_servicos_de_comercio_de_informatica_ltda, orient_professionals).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informações, right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, not_maintain_confidentiality).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, subjection, tyco_servicos_de_comercio_de_informatica_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_warning).
legal_relation_instance(clausula_decima_oitava_penalidades, subjection, tyco_servicos_de_comercio_de_informatica_ltda, be_subject_to_warning).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_fine).
legal_relation_instance(clausula_decima_oitava_penalidades, subjection, tyco_servicos_de_comercio_de_informatica_ltda, be_subject_to_fine).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_temporarily).
legal_relation_instance(clausula_decima_oitava_penalidades, subjection, tyco_servicos_de_comercio_de_informatica_ltda, be_subject_to_suspension).
legal_relation_instance(clausula_decima_oitava_penalidades, right_to_action, tyco_servicos_de_comercio_de_informatica_ltda, request_reconsideration).
legal_relation_instance(clausula_decima_oitava_penalidades, power, tyco_servicos_de_comercio_de_informatica_ltda, interpose_appeal).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_amendment).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, no_right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, must_formalize_amendment).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, agree_to_contract_amendment).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, compensate_for_refusal).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, face_penalties_for_refusal).
legal_relation_instance(clausula_vigésima_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_consensually).
legal_relation_instance(clausula_vigésima_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_other_party_of_breach).
legal_relation_instance(clausula_vigésima_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_for_lack_of_area).
legal_relation_instance(clausula_vigésima_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_for_suspension).
legal_relation_instance(clausula_vigésima_extinção_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_for_breach).
legal_relation_instance(clausula_vigésima_primeira_disposições_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights).
legal_relation_instance(clausula_vigésima_primeira_disposições_finais, permission_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_enforcement).
legal_relation_instance(clausula_vigésima_primeira_disposições_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, claim_waiver).
legal_relation_instance(clausula_vigésima_segunda_foro, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, choose_rio_de_janeiro_forum).
legal_relation_instance(clausula_vigésima_segunda_foro, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, be_subject_to_rio_de_janeiro_forum).
legal_relation_instance(clausula_vigésima_segunda_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, choose_different_forum).

% --- Action catalog (local to this contract grounding) ---
action_type(act_according_to_principles).
action_label(act_according_to_principles, 'Act according to principles').
action_type(act_according_to_principles_bndes).
action_label(act_according_to_principles_bndes, 'Act according to principles').
action_type(act_in_good_faith).
action_label(act_in_good_faith, 'Act in good faith').
action_type(act_in_good_faith_bndes).
action_label(act_in_good_faith_bndes, 'Act in good faith').
action_type(adopt_sustainability_practices).
action_label(adopt_sustainability_practices, 'Adopt sustainability practices').
action_type(adopt_sustainable_practices).
action_label(adopt_sustainable_practices, 'Adopt sustainable practices').
action_type(agree_to_contract_amendment).
action_label(agree_to_contract_amendment, 'Agree to contract amendment').
action_type(allow_inspections).
action_label(allow_inspections, 'Allow inspections').
action_type(analyze_price_revision_request).
action_label(analyze_price_revision_request, 'Analyze price revision request').
action_type(answer_for_expenses).
action_label(answer_for_expenses, 'Answer for expenses').
action_type(apply_fine).
action_label(apply_fine, 'Apply fine').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_warning).
action_label(apply_warning, 'Apply warning').
action_type(appoint_representative).
action_label(appoint_representative, 'Appoint representative').
action_type(assume_responsibility_for_tax_documents).
action_label(assume_responsibility_for_tax_documents, 'Assume responsibility for tax documents').
action_type(assume_technical_responsibility).
action_label(assume_technical_responsibility, 'Assume technical responsibility').
action_type(be_subject_to_fine).
action_label(be_subject_to_fine, 'Be subject to fine').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(be_subject_to_rio_de_janeiro_forum).
action_label(be_subject_to_rio_de_janeiro_forum, 'Subject to Rio forum').
action_type(be_subject_to_suspension).
action_label(be_subject_to_suspension, 'Be subject to suspension').
action_type(be_subject_to_warning).
action_label(be_subject_to_warning, 'Be subject to warning').
action_type(bear_burden_quantification_error).
action_label(bear_burden_quantification_error, 'Bear burden of quantification error').
action_type(cannot_request_price_review_after_contract_end).
action_label(cannot_request_price_review_after_contract_end, 'Cannot request price review after contract end').
action_type(choose_different_forum).
action_label(choose_different_forum, 'Choose different forum').
action_type(choose_rio_de_janeiro_forum).
action_label(choose_rio_de_janeiro_forum, 'Choose Rio forum').
action_type(claim_waiver).
action_label(claim_waiver, 'Claim waiver').
action_type(communicate_facts_to_bndes).
action_label(communicate_facts_to_bndes, 'Communicate facts to BNDES').
action_type(communicate_penalty_imposition).
action_label(communicate_penalty_imposition, 'Communicate penalty').
action_type(compensate_for_refusal).
action_label(compensate_for_refusal, 'Compensate damages for refusal').
action_type(comply_with_laws).
action_label(comply_with_laws, 'Comply with laws').
action_type(deduct_payments).
action_label(deduct_payments, 'Deduct payments').
action_type(deduct_penalty_from_payment).
action_label(deduct_penalty_from_payment, 'Deduct penalty from payment').
action_type(demand_execution).
action_label(demand_execution, 'Demand execution').
action_type(demand_indemnification).
action_label(demand_indemnification, 'Demand indemnification').
action_type(do_not_transfer_responsibility).
action_label(do_not_transfer_responsibility, 'Do not transfer responsibility').
action_type(effect_object_receipt).
action_label(effect_object_receipt, 'Effect object receipt').
action_type(ensure_security_compliance).
action_label(ensure_security_compliance, 'Ensure security compliance').
action_type(exclude_from_simples_nacional).
action_label(exclude_from_simples_nacional, 'Exclude from Simples Nacional').
action_type(execute_contract_object).
action_label(execute_contract_object, 'Execute contract object').
action_type(exercise_rights).
action_label(exercise_rights, 'Exercise rights').
action_type(expect_contract_duration).
action_label(expect_contract_duration, 'Expect contract duration').
action_type(extend_guarantee_presentation_period).
action_label(extend_guarantee_presentation_period, 'Extend guarantee period').
action_type(face_penalties_for_refusal).
action_label(face_penalties_for_refusal, 'Subject to penalties').
action_type(formalize_contract_amendment).
action_label(formalize_contract_amendment, 'Formalize amendment if essential').
action_type(have_defective_goods_replaced).
action_label(have_defective_goods_replaced, 'Have defective goods replaced').
action_type(identify_employees).
action_label(identify_employees, 'Identify employees').
action_type(include_required_information).
action_label(include_required_information, 'Include required information').
action_type(interpose_appeal).
action_label(interpose_appeal, 'Interpose appeal').
action_type(maintain_confidentiality).
action_label(maintain_confidentiality, 'Maintain confidentiality').
action_type(maintain_integrity_public_private_relations).
action_label(maintain_integrity_public_private_relations, 'Maintain integrity in public-private relations').
action_type(maintain_integrity_public_private_relations_bndes).
action_label(maintain_integrity_public_private_relations_bndes, 'Maintain integrity in public-private relations').
action_type(maintain_qualification_conditions).
action_label(maintain_qualification_conditions, 'Maintain qualification conditions').
action_type(meet_bndes_demands).
action_label(meet_bndes_demands, 'Meet BNDES demands').
action_type(must_formalize_amendment).
action_label(must_formalize_amendment, 'Must formalize amendment').
action_type(no_right_celebrate_additives).
action_label(no_right_celebrate_additives, 'No right to celebrate addenda').
action_type(not_maintain_confidentiality).
action_label(not_maintain_confidentiality, 'Not maintain confidentiality (counterpart)').
action_type(notify_other_party_of_breach).
action_label(notify_other_party_of_breach, 'Notify other party of breach').
action_type(notify_unauthorized_disclosure).
action_label(notify_unauthorized_disclosure, 'Notify unauthorized disclosure').
action_type(obey_instructions).
action_label(obey_instructions, 'Obey instructions').
action_type(observe_policies_and_code).
action_label(observe_policies_and_code, 'Observe policies and code').
action_type(obtain_guarantor_consent).
action_label(obtain_guarantor_consent, 'Obtain guarantor consent').
action_type(obtain_new_guarantee).
action_label(obtain_new_guarantee, 'Obtain new guarantee').
action_type(omit_celebration_additives).
action_label(omit_celebration_additives, 'Omit celebration of addenda').
action_type(omit_enforcement).
action_label(omit_enforcement, 'Omit enforcement').
action_type(orient_professionals).
action_label(orient_professionals, 'Instruct professionals').
action_type(pay_charges_and_taxes).
action_label(pay_charges_and_taxes, 'Pay charges and taxes').
action_type(pay_contracted_party).
action_label(pay_contracted_party, 'Pay the contracted party').
action_type(present_dif).
action_label(present_dif, 'Present DIF').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(prevent_allocation_of_family).
action_label(prevent_allocation_of_family, 'Prevent allocation of family').
action_type(prevent_favoritism).
action_label(prevent_favoritism, 'Prevent favoritism').
action_type(prevent_undue_advantage).
action_label(prevent_undue_advantage, 'Prevent undue advantage').
action_type(provide_clarifications).
action_label(provide_clarifications, 'Provide clarifications').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_notebooks).
action_label(provide_notebooks, 'Provide notebooks').
action_type(provide_signed_confidentiality_terms).
action_label(provide_signed_confidentiality_terms, 'Provide signed confidentiality terms').
action_type(provide_supporting_documents).
action_label(provide_supporting_documents, 'Provide supporting documents').
action_type(provide_warranty_for_goods).
action_label(provide_warranty_for_goods, 'Provide warranty').
action_type(receive_goods_warranty).
action_label(receive_goods_warranty, 'Receive goods warranty').
action_type(receive_notebooks).
action_label(receive_notebooks, 'Receive notebooks').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payment_for_execution).
action_label(receive_payment_for_execution, 'Receive service and pay').
action_type(reject_out_of_time_document).
action_label(reject_out_of_time_document, 'Reject out of time document').
action_type(remove_agents_causing_impediments).
action_label(remove_agents_causing_impediments, 'Remove agents causing impediments').
action_type(repair_damages).
action_label(repair_damages, 'Repair damages').
action_type(repair_object_of_contract).
action_label(repair_object_of_contract, 'Repair object').
action_type(replace_defective_goods).
action_label(replace_defective_goods, 'Replace defective goods').
action_type(report_irregularities).
action_label(report_irregularities, 'Report irregularities').
action_type(request_price_review).
action_label(request_price_review, 'Request price review').
action_type(request_price_review_before_contract_end).
action_label(request_price_review_before_contract_end, 'Request price review before contract end').
action_type(request_reconsideration).
action_label(request_reconsideration, 'Request reconsideration').
action_type(return_documents).
action_label(return_documents, 'Return documents').
action_type(return_resources).
action_label(return_resources, 'Return resources').
action_type(reverse_engineer_bndes_software).
action_label(reverse_engineer_bndes_software, 'No right to reverse engineer').
action_type(review_prices).
action_label(review_prices, 'Review prices').
action_type(send_document_digitally).
action_label(send_document_digitally, 'Send document digitally').
action_type(solve_defects).
action_label(solve_defects, 'Solve defects').
action_type(solve_defects_in_5_days).
action_label(solve_defects_in_5_days, 'Solve defects within 5 days').
action_type(summon_contracted_party_to_provide_guarantee).
action_label(summon_contracted_party_to_provide_guarantee, 'Summon guarantee').
action_type(suspend_temporarily).
action_label(suspend_temporarily, 'Suspend temporarily').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').
action_type(terminate_contract_consensually).
action_label(terminate_contract_consensually, 'Terminate contract consensually').
action_type(terminate_contract_for_breach).
action_label(terminate_contract_for_breach, 'Terminate contract for breach').
action_type(terminate_contract_for_lack_of_area).
action_label(terminate_contract_for_lack_of_area, 'Terminate for lack of area').
action_type(terminate_contract_for_suspension).
action_label(terminate_contract_for_suspension, 'Terminate for suspension').
action_type(use_or_copy_bndes_info_without_permission).
action_label(use_or_copy_bndes_info_without_permission, 'No right to use BNDES info').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_167_2023).
contract_metadata(contrato_ocs_167_2023, numero_ocs, '167/2023').
contract_metadata(contrato_ocs_167_2023, numero_sap, '4400005533').
contract_metadata(contrato_ocs_167_2023, tipo_contrato, 'CONTRATO DE FORNECIMENTO DE BENS').
contract_metadata(contrato_ocs_167_2023, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'TYCO SERVIÇOS DE COMÉRCIO DE INFORMÁTICA LTDA']).
contract_metadata(contrato_ocs_167_2023, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_167_2023, contratado, 'TYCO SERVIÇOS DE COMÉRCIO DE INFORMÁTICA LTDA').
contract_metadata(contrato_ocs_167_2023, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_167_2023, cnpj_contratado, '33.260.627/0001-30').
contract_metadata(contrato_ocs_167_2023, procedimento_licitatorio, 'Pregão Eletrônico nº 004/2023 - BNDES').
contract_metadata(contrato_ocs_167_2023, data_autorizacao, '24/03/2023').
contract_metadata_raw(contrato_ocs_167_2023, 'ip_ati_deset', '003/2023', 'Texto do contrato').
contract_metadata(contrato_ocs_167_2023, data_ip_ati_degat, '21/03/2023').
contract_metadata(contrato_ocs_167_2023, rubrica_orcamentaria, '1750100071').
contract_metadata(contrato_ocs_167_2023, centro_custo, 'BN30005000').
contract_metadata(contrato_ocs_167_2023, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_167_2023, regulamento, 'Regulamento Licitações e Contratos do Sistema BNDES').
contract_clause(contrato_ocs_167_2023, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto o fornecimento de computadores portáteis (notebooks), conforme especificações constantes do Termo de Referência (Anexo I do Edital do Pregão Eletrônico nº 004/2023 - BNDES) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_167_2023, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 6 (seis) meses, a contar da data de sua assinatura.').
contract_clause(contrato_ocs_167_2023, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Termo de Referência (Anexo I deste Contrato) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_167_2023, clausula_quarta_recebimento_objeto, 'CLÁUSULA QUARTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através da Comissão de Recebimento mencionada na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_167_2023, clausula_quinta_garantia_dos_bens_fornecidos, 'CLÁUSULA QUINTA - GARANTIA DOS BENS FORNECIDOS', 'A garantia será de 36 (trinta e seis) meses, contados do recebimento definitivo dos bens em questão, salvo se a proposta (Anexo II deste Contrato) previr prazo maior, observado o disposto no Anexo I (Termo de Referência) deste Contrato.  Parágrafo Primeiro A garantia ocorrerá sem nenhum ônus para o BNDES e será prestada sob responsabilidade do CONTRATADO, inclusive quando for necessário o transporte dos bens ou ainda o traslado e a hospedagem de técnicos do CONTRATADO ou qualquer outro tipo de serviço necessário para o cumprimento da garantia.  Parágrafo Segundo O CONTRATADO deverá solucionar todos os vícios e defeitos apresentados pelos bens, dentro do período de garantia, no prazo de 5 (cinco) dias a contar da data da abertura do chamado ou da retirada do equipamento, podendo substitui-los por outros bens, novos e perfeitos, que atendam às mesmas especificações estipuladas neste Contrato e em seus Anexos, no mesmo prazo para o conserto.').
contract_clause(contrato_ocs_167_2023, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de até R$ 690.030,00 (seiscentos e noventa mil e trinta reais), conforme proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento:  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização ao CONTRATADO.   Parágrafo Quarto  O CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua proposta, devendo, conforme o caso: I. complementá-los, caso os quantitativos previstos inicialmente em sua proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato; ou II. reverter o excedente como lucro, sendo facultada ao BNDES a promoção de negociação com vistas a eventual prorrogação contratual.').
contract_clause(contrato_ocs_167_2023, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, em parcela única, por meio de crédito em conta bancária, em até 10 (dez) dias úteis a contar da data de apresentação do documento fiscal ou equivalente legal (prioritariamente  nota fiscal, e nos casos de dispensa da nota fiscal: fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Termo de Referência) deste Instrumento.  Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte do fornecimento do bem.  Parágrafo Segundo A apresentação do documento de cobrança fora do prazo previsto nesta cláusula poderá implicar em sua rejeição e no direito do BNDES se ressarcir, preferencialmente, mediante desconto do valor a ser pago ao CONTRATADO, por qualquer penalidade tributária incidente pelo atraso.  Parágrafo Terceiro Nas hipóteses em que o recebimento definitivo ocorrer após a entrega do documento fiscal ou equivalente legal, o BNDES terá até 10 (dez) dias úteis, a contar da data em que o objeto tiver sido recebido definitivamente, para efetuar o pagamento.  Parágrafo Quarto Para toda efetivação de pagamento, o Contratado deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica ou protocolar em sistema eletrônico próprio do BNDES, considerando as orientações do Contratante vigentes na ocasião do pagamento. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento.  Parágrafo Quinto  O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. descrição detalhada do objeto executado e dos respectivos valores; V. período de referência da execução do objeto; VI. nome e número do [CNPJ / CPF] do CONTRATADO, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; VIII. nome e número do banco e da agência, bem como o número da conta corrente do CONTRATADO, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; IX. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; X. CNPJ do tomador do serviço: 33.657.248/0001-89; XI. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento - DIF; XIII. número de inscrição do contribuinte individual válido junto ao INSS (NIT ou PIS/PASEP); e XIV. destaque das retenções tributárias aplicáveis, conforme estabelecido na DIF.  Parágrafo Sexto Os pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pelo CONTRATADO. Em casos de dispensa ou benefício fiscal que implique em redução ou eliminação da retenção de tributos, o CONTRATADO fornecerá todos os documentos comprobatórios.  Parágrafo Sétimo Caso o CONTRATADO emita documento fiscal ou equivalente legal autorizado por Estado diferente daquele onde se localiza o estabelecimento do BNDES adquirente do bem e destinatário da cobrança, deverá considerar a condição de não contribuinte do BNDES na emissão da nota fiscal e no recolhimento do diferencial de alíquota do ICMS, se houver.  Parágrafo Oitavo O documento fiscal ou equivalente legal emitido pelo CONTRATADO deverá estar em conformidade com a legislação do Estado onde o CONTRATADO esteja estabelecida, cuja regularidade fiscal foi avaliada na etapa de habilitação, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos, sob pena de devolução do documento e interrupção do prazo para pagamento.    Parágrafo Nono  Ao documento fiscal ou equivalente legal deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que o CONTRATADO é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; e IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado.  Parágrafo Décimo Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADO ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Décimo Primeiro Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pelo CONTRATADO.  Parágrafo Décimo Segundo Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.  Parágrafo Décimo Terceiro Fica assegurado ao BNDES o direito de deduzir do pagamento devido ao CONTRATADO, por força deste Contrato ou de outro contrato mantido com o BNDES, o valor correspondente aos pagamentos efetuados a maior ou em duplicidade.').
contract_clause(contrato_ocs_167_2023, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO', 'Considerando o prazo de vigência do presente Contrato, não se admite reajuste ou repactuação de preços, devendo o CONTRATADO arcar com eventuais elevações dos custos decorrentes de fatores ordinários, tais como alterações de acordo ou convenção coletiva de trabalho.  Parágrafo Primeiro O BNDES e o CONTRATADO têm direito à revisão de preços, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, desde que ocorra fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou  desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. a revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO. Neste último caso, o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta e do momento do pedido da revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Segundo O CONTRATADO deverá solicitar a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador da revisão de preços ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador, para solicitar a revisão de preços; II. o BNDES deverá analisar o pedido de revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e III. caso o CONTRATADO não solicite a revisão de preços nos prazos fixados acima, não fará jus à mesma, operando-se a renúncia ao seu eventual direito.').
contract_clause(contrato_ocs_167_2023, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS', 'O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro É vedada a celebração de aditivos decorrentes de eventos supervenientes alocados, na Matriz de Riscos, como de responsabilidade do CONTRATADO.').
contract_clause(contrato_ocs_167_2023, clausula_decima_garantia_contratual, 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL', 'O CONTRATADO prestará, no prazo de até 10 (dez) dias úteis, contados da convocação, garantia contratual, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 34.501,50 (trinta e quatro mil, quinhentos e um reais e cinquenta centavos), que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocação; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas ao CONTRATADO; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Havendo majoração do preço contratado, decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, fica dispensada a  atualização da garantia, salvo se o valor da atualização for igual ou superior ao patamar referenciado no inciso II do artigo 91 do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Terceiro Nos demais casos que demandem a complementação ou renovação da garantia, tais como alteração do objeto (aditivo quantitativo ou qualitativo), prorrogação contratual, dentre outros, o CONTRATADO deverá providenciá-la no prazo estipulado pelo BNDES.   Parágrafo Quarto Sempre que o contrato for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao CONTRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.').
contract_clause(contrato_ocs_167_2023, clausula_decima_primeira_obrigações_contratado, 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DO CONTRATADO', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que venha a emitir em desacordo com a legislação aplicável. VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante:  a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; XI. responder, em relação aos seus profissionais, por todas as despesas decorrentes da execução dos serviços, tais como: salários, seguros de acidente, taxas, impostos, contribuições, indenizações, vales-refeição, vales-transportes e outras que porventura venham a ser criadas e exigidas pelo Poder Público ou no instrumento coletivo da categoria.; XII. apresentar, em até 10 dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal;  XIII. assumir inteira responsabilidade técnica e administrativa em relação ao objeto contratado, não podendo, sob qualquer hipótese, transferir a terceiros a responsabilidade por problemas ou falhas, não estando vedada a continuidade do Contrato se sobrevier regular reorganização societária, tal como cisão, incorporação ou fusão; XIV.  atender prontamente quaisquer exigências do representante do BNDES, no que diz respeito às suas necessidades. XV.  prestar todos os esclarecimentos que lhe forem solicitados pelo BNDES. XVI. notificar prontamente ao BNDES qualquer divulgação ou uso não autorizado de informações que porventura tomar conhecimento, adotando todas as medidas recomendadas pelo BNDES para remediar qualquer divulgação ou uso. XVII. informar ao BNDES toda e qualquer irregularidade observada no curso da execução contratual. Não usar, copiar, duplicar ou de alguma outra forma reproduzir ou reter todas ou quaisquer informações do BNDES, exceto se autorizada previamente, por escrito, pelo BNDES. Não efetuar a compilação reversa, montagem reversa ou engenharia reversa de qualquer programa aplicativo do BNDES ou de terceiros a que venha ter acesso por força do serviço. XVIII. identificar seus funcionários com crachás da empresa e informar os horários em que estes efetuarão os serviços no BNDES;  XIX. devolver, impreterivelmente, ao término do Contrato, ou a qualquer tempo a pedido do BNDES, todos os documentos que o BNDES o tenha fornecido. XX. devolver ao final do Contrato recursos fornecidos pelo BNDES sob pena de indenização dos danificados ou perdidos; XXI. adotar, sempre que cabível, na execução do Contrato, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição; XXII. responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos seus profissionais alocados na execução do Contrato, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES; XXIII. cumprir, durante a execução do Contrato, as leis federais, estaduais e municipais vigentes ou que entrarem em vigor, sendo a única responsável pelas infrações cometidas, convencionando-se, desde já, que o BNDES poderá descontar de qualquer crédito da Contratada a importância correspondente a eventuais pagamentos desta natureza que venha efetuar por imposição legal; e').
contract_clause(contrato_ocs_167_2023, clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, 'CLÁUSULA DÉCIMA SEGUNDA – CONDUTA ÉTICA DO CONTRATADO E DO BNDES', 'O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar a Política para Transações com Partes Relacionadas e o Código de Ética do Sistema BNDES vigentes ao tempo da contratação, bem como a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes,  administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_167_2023, clausula_decima_terceira_sigilo_das_informações, 'CLÁUSULA DÉCIMA TERCEIRA – SIGILO DAS INFORMAÇÕES', 'Caso o CONTRATADO venha a ter acesso a dados, materiais, documentos e informações de natureza sigilosa, direta ou indiretamente, em decorrência da execução do objeto contratual, deverá manter o sigilo dos mesmos, bem como orientar os profissionais envolvidos a cumprir esta obrigação, respeitando-se as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES.  Parágrafo Único Assim que solicitado pelo Gestor do Contrato, o CONTRATADO deverá providenciar a assinatura, por seu representante legal e pelos profissionais que tiverem acesso a informações sigilosas, dos Termos de Confidencialidade a serem disponibilizados pelo BNDES.').
contract_clause(contrato_ocs_167_2023, clausula_decima_quarta_acesso_protecao_dados_pessoais, 'CLÁUSULA DÉCIMA QUARTA – ACESSO E PROTEÇÃO DE DADOS PESSOAIS', 'As partes assumem o compromisso de proteger os direitos fundamentais de liberdade e de privacidade, relativos ao tratamento de dados pessoais, nos meios físicos e digitais, devendo, para tanto, adotar medidas corretas de segurança sob o aspecto técnico, jurídico e administrativo, e observar que:    I.Eventual tratamento de dados em razão do presente Contrato deverá ser realizado conforme os parâmetros previstos na legislação, especialmente na Lei n° 13.709/2018 – Lei Geral de Proteção de Dados - LGPD, dentro de propósitos legítimos, específicos, explícitos e informados ao titular;   II.O tratamento será limitado às atividades necessárias ao atingimento das finalidades contratuais e, caso seja necessário, ao cumprimento de suas obrigações legais ou regulatórias, sejam de ordem principal ou acessória, observando-se que, em caso de necessidade de coleta de dados pessoais, esta será realizada mediante prévia aprovação do BNDES, responsabilizando-se o CONTRATADO por obter o consentimento dos titulares, salvo nos casos em que a legislação dispense tal medida;  III.O CONTRATADO deverá seguir as instruções recebidas do BNDES em relação ao tratamento de dados pessoais;  IV.O CONTRATADO se responsabilizará como “Controlador de dados” no caso do tratamento de dados para o cumprimento de suas obrigações legais ou regulatórias, devendo obedecer aos parâmetros previstos na legislação;  V.Os dados coletados somente poderão ser utilizados pelas partes, seus representantes, empregados e prestadores de serviços diretamente alocados na execução contratual, sendo que, em hipótese alguma, poderão ser compartilhados ou utilizados para outros fins, sem a prévia autorização do BNDES, ou caso haja alguma ordem judicial, observando-se as medidas legalmente previstas para tanto;  VI.O CONTRATADO deve manter a confidencialidade dos dados pessoais obtidos em razão do presente contrato, devendo adotar as medidas técnicas e administrativas adequadas e necessárias, visando assegurar a proteção dos dados, nos termos do artigo 46 da LGPD, de modo a garantir um nível apropriado de segurança e a prevenção e mitigação de eventuais riscos;  VII.Os dados deverão ser armazenados de maneira segura pelo CONTRATADO, que utilizará recursos de segurança da informação e tecnologia adequados, inclusive quanto a mecanismos de detecção e prevenção de ataques cibernéticos e incidentes de segurança da informação.   VIII.O CONTRATADO dará conhecimento formal para seus empregados e/ou prestadores de serviço acerca das disposições previstas nesta Cláusula e na Cláusula de Sigilo das Informações, responsabilizando-se por eventual uso indevido dos dados pessoais, bem como por quaisquer falhas nos sistemas por ela empregados para o tratamento dos dados.   IX.O BNDES possui direito de regresso em face do CONTRATADO em razão de eventuais danos causados por este em decorrência do descumprimento das responsabilidades e obrigações previstas no âmbito deste contrato e da Lei Geral de Proteção de Dados Pessoais;  X.O CONTRATADO deverá disponibilizar ao titular do dado um canal ou sistema em que seja garantida consulta facilitada e gratuita sobre a forma, a duração do tratamento e a integralidade de seus dados pessoais.  XI.O CONTRATADO deverá informar imediatamente ao BNDES todas as solicitações recebidas em razão do exercício dos direitos pelo titular dos dados relacionados a este Contrato, seguindo as orientações fixadas pelo BNDES e pela legislação em vigor para o adequado endereçamento das demandas.  XII.O CONTRATADO deverá manter registro de todas as operações de tratamento de dados pessoais que realizar no âmbito do Contrato disponibilizando, sempre que solicitado pelo BNDES, as informações necessárias à produção do Relatório de Impacto de Dados Pessoais, disposto no artigo 5º, XVII, da Lei Geral de Proteção de Dados Pessoais.  XIII.Qualquer incidente que implique em violação ou risco de violação ou vazamento de dados pessoais deverá ser prontamente comunicado ao BNDES, informando-se também todas as providências adotadas e os dados pessoais eventualmente afetados, cabendo ao CONTRATADO disponibilizar as informações e documentos solicitados e colaborar com qualquer investigação ou auditoria que venha a ser realizada.  XIV.Ao final da vigência do Contrato, o CONTRATADO deverá eliminar de sua base de informações todo e qualquer dado pessoal que tenha tido acesso em razão da execução do objeto contratado, salvo quando tenha que manter a informação para o cumprimento de obrigação legal.  Parágrafo Primeiro  As Partes reconhecem que, se durante a execução do Contrato armazenarem, coletarem, tratarem ou de qualquer outra forma processarem dados pessoais, no sentido dado pela legislação vigente aplicável, o BNDES será considerado “Controlador de Dados”, e o CONTRATADO “Operador” ou “Processador de Dados”, salvo nas situações expressas em contrário nesse Contrato. Contudo, caso o CONTRATADO descumpra as obrigações prevista na legislação de proteção de dados ou as instruções do BNDES, será equiparado a “Controlador de Dados”, inclusive para fins de sua responsabilização por eventuais danos causados.  Parágrafo Segundo Caso o CONTRATADO disponibilize dados de terceiros, além das obrigações no caput desta Cláusula, deve se responsabilizar por eventuais danos que o BNDES venha a sofrer em decorrência de uso indevido de dados pessoais por parte do CONTRATADO, sempre que ficar comprovado que houve falha de segurança técnica e administrativa, descumprimento de regras previstas na legislação de proteção à privacidade e dados pessoais, e das orientações do BNDES, sem prejuízo das penalidades deste contrato.  Parágrafo Terceiro A transferência internacional de dados deve se dar em caráter excepcional e na estrita observância da legislação, especialmente, dos artigos 33 a 36 da Lei n° 13.709/2018 e nos normativos do Banco Central do Brasil relativos ao processamento e armazenamento de dados das instituições financeiras, e dependerá de autorização prévia do BNDES ao CONTRATADO.   Parágrafo Quarto A assinatura deste Contrato importa na manifestação de inequívoco consentimento do titular, seja ele pessoa física direta ou indiretamente relacionada ao CONTRATADO, inclusive sócios, representantes legais, empregados, contratados e/ou terceirizados, quando for o caso, dos dados pessoais que tenham se tornados públicos como condição para participação na licitação e para contratação, para tratamento pelo BNDES, na forma da Lei nº 13.709/2018. Poderão ser solicitados pelo BNDES dados pessoais adicionais a fim de viabilizar o cumprimento de obrigação legal.  Parágrafo Quinto Os representantes legais signatários do presente autorizam a divulgação dos dados pessoais expressamente contidos nos documentos decorrentes do procedimento de licitação, tais como nome, CPF, e-mail, telefone e cargo, para fins de publicidade das contratações administrativas no site institucional do BNDES e em cumprimento à Lei nº 12.527/ 2011 (Lei de Acesso à Informação).  Parágrafo Sexto As partes comprometem-se a coletar o consentimento, quando necessário, conforme previsto na Lei no 13.709/2018 (Lei Geral de Proteção de Dados - LGPD), bem como informar os titulares dos dados pessoais mencionados no presente instrumento, para as finalidades descritas no parágrafo acima.'.
contract_clause(contrato_ocs_167_2023, clausula_decima_quinta_obrigacoes_bndes, 'CLÁUSULA DÉCIMA QUINTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Flávia Tacques do Rego Monteiro, que atualmente exerce a função de Gerente da ATI/DESET/GEAT, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. designar, como substituto do Gestor do Contrato, para atuar em sua eventual ausência,  quem estiver substituindo na função de gerente; IV. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita ao CONTRATADO; V. designar a Comissão de Recebimento, a quem caberá o recebimento do objeto, em conjunto com o Gestor do Contrato;   VI. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, acesso ao Código de Ética do Sistema BNDES, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VII. colocar à disposição do CONTRATADO todas as informações necessárias ao perfeito fornecimento dos bens objeto deste Contrato; e VIII. comunicar ao CONTRATADO, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.'.
contract_clause(contrato_ocs_167_2023, clausula_decima_sexta_equidade_genero_valorizacao_diversidade, 'CLÁUSULA DÉCIMA SEXTA – EQUIDADE DE GÊNERO E VALORIZAÇÃO DA DIVERSIDADE', 'O CONTRATADO deverá comprovar, sempre que solicitado pelo BNDES, a inexistência de decisão administrativa final sancionadora, exarada por autoridade ou órgão competente, em razão da prática de atos, pelo próprio CONTRATADO ou dirigentes, administradores ou sócios majoritários, que importem em discriminação de raça ou gênero, trabalho infantil ou trabalho escravo, e de sentença condenatória transitada em julgado, proferida em decorrência dos referidos atos, e, se for o caso, de outros que caracterizem assédio moral ou sexual e importem em crime contra o meio ambiente.   Parágrafo Primeiro Na hipótese de ter havido decisão administrativa e/ou sentença condenatória, nos termos referidos no caput desta Cláusula, a execução do objeto contratual poderá ser suspensa pelo BNDES até a comprovação do cumprimento da reparação imposta ou da reabilitação do CONTRATADO ou de seus dirigentes, conforme o caso.  Parágrafo Segundo A comprovação a que se refere o caput desta Cláusula será realizada por meio de declaração, sem prejuízo da verificação do sistema informativo interno do BNDES – Sistema de Gerenciamento do Cadastro de Entidades (N02), acerca da inexistência de sanção em face do CONTRATADO e/ou de seus dirigentes, administradores ou sócios majoritários que impeça a contratação.'.
contract_clause(contrato_ocs_167_2023, clausula_decima_setima_cessao_contrato_credito_sucessao_subcontratacao, 'CLÁUSULA DÉCIMA SÉTIMA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', 'É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo.   Parágrafo Primeiro É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.'.
contract_clause(contrato_ocs_167_2023, clausula_decima_oitava_penalidades, 'CLÁUSULA DÉCIMA OITAVA – PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: I. advertência; II. multa, de acordo com o Anexo I (Termo de Referência); e III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades serão aplicadas observadas as normas do Regulamento de Licitações e Contratos das Empresas Integrantes do SISTEMA BNDES.   Parágrafo Segundo  Contra a decisão de aplicação de penalidade, o CONTRATADO poderá requerer a reconsideração para a decisão de advertência, ou interpor o recurso cabível para as demais penalidades, na forma e no prazo previstos no Regulamento de Licitações e Contratos do SISTEMA BNDES.  Parágrafo Terceiro  A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto  A multa poderá ser aplicada juntamente com as demais penalidades.   Parágrafo Quinto  A multa aplicada ao CONTRATADO e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto  No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Sétimo A celebração de Termo de Ajustamento de Conduta prevista no Regulamento de Licitações e Contratos do Sistema BNDES não importa em renúncia às penalidades prevista neste Contrato e no Anexo I (Termo de Referência).  Parágrafo Oitavo A sanção prevista no inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_167_2023, clausula_decima_nona_alterações_contratuais, 'CLÁUSULA DÉCIMA NONA – ALTERAÇÕES CONTRATUAIS', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo       A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.      Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento, os ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato e alterações de preços decorrentes decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, que poderão ser celebrados por meio epistolar.').
contract_clause(contrato_ocs_167_2023, clausula_vigésima_extinção_contrato, 'CLÁUSULA VIGÉSIMA – EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, e ainda: I. Consensualmente, formalizada em autorização escrita e fundamentada do BNDES, mediante aviso prévio por escrito, com antecedência mínima de 90 (noventa) dias ou de prazo menor a ser negociado pelas partes à época da rescisão; II. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; III. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo;  IV. quando for decretada a falência do CONTRATADO; V. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VI. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  VIII. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; IX. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; X. em razão da dissolução do CONTRATADO;  XI. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.     Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_167_2023, clausula_vigésima_primeira_disposições_finais, 'CLÁUSULA VIGÉSIMA PRIMEIRA - DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram o presente Contrato: Anexo I - Termo de Referência do Pregão Eletrônico nº 004/2023 - BNDES Anexo II - Proposta Anexo III - Matriz de Risco Anexo IV - Termo de Confidencialidade para Representante Legal Anexo V – Termo de Confidencialidade para Profissionais  Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_167_2023, clausula_vigésima_segunda_foro, 'CLÁUSULA VIGÉSIMA SEGUNDA – FORO', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As partes consideram, para todos os efeitos, a data da última assinatura digital como a data de formalização jurídica deste instrumento.  As folhas deste contrato foram conferidas por Márcio Oliveira da Rocha, advogado do BNDES, por autorização do representante legal que o assina.   _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES   _____________________________________________________________________ TYCO SERVIÇOS DE COMÉRCIO DE INFORMÁTICA LTDA').

% ===== END =====
