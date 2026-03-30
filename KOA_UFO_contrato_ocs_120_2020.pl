% ===== KOA Combined Output | contract_id: contrato_ocs_120_2020 =====

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
% UFO-only grounding generated from: KOA_Contrato_OCS_120_2020_-_Art_Stars.pl
% contract_id: contrato_ocs_120_2020

instance_of(contrato_ocs_120_2020, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(art_stars_software_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_120_2020).
plays_role(art_stars_software_ltda, hired_service_provider_role, contrato_ocs_120_2020).

clause_of(clausula_primeira_objeto, contrato_ocs_120_2020).
clause_of(clausula_segunda_vigencia, contrato_ocs_120_2020).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_120_2020).
clause_of(clausula_quarta_recebimento_objeto, contrato_ocs_120_2020).
clause_of(clausula_quinta_preco, contrato_ocs_120_2020).
clause_of(clausula_sexta_pagamento, contrato_ocs_120_2020).
clause_of(clausula_setima_equilibrio_economico_financeiro_contrato, contrato_ocs_120_2020).
clause_of(clausula_oitava_matriz_riscos, contrato_ocs_120_2020).
clause_of(clausula_nona_obrigacoes_contratado, contrato_ocs_120_2020).
clause_of(clausula_decima_conduta_etica_contratado_bndes, contrato_ocs_120_2020).
clause_of(clausula_decima_primeira_sigilo_informacoes, contrato_ocs_120_2020).
clause_of(clausula_decima_segunda_obrigacoes_bndes, contrato_ocs_120_2020).
clause_of(clausula_decima_terceira_cessao_contrato_credito_sucessao_subcontratacao, contrato_ocs_120_2020).
clause_of(clausula_decima_quarta_penalidades, contrato_ocs_120_2020).
clause_of(clausula_decima_quinta_alterações_contratuais, contrato_ocs_120_2020).
clause_of(clausula_decima_sexta_extinção_contrato, contrato_ocs_120_2020).
clause_of(clausula_decima_setima_disposições_finais, contrato_ocs_120_2020).
clause_of(clausula_decima_oitava_foro, contrato_ocs_120_2020).

legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, acquire_licenses).
legal_relation_instance(clausula_primeira_objeto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, define_contract_scope).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, fulfill_contract_for_60_days).
legal_relation_instance(clausula_segunda_vigencia, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, enforce_contract_for_60_days).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, art_stars_software_ltda, execute_contract_object).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_execution_per_specs).
legal_relation_instance(clausula_quarta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effectuate_object_receipt).
legal_relation_instance(clausula_quarta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effectuate_object_receipt).
legal_relation_instance(clausula_quinta_preco, duty_to_act, art_stars_software_ltda, bear_cost_of_quantity_mismatch).
legal_relation_instance(clausula_quinta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_for_licenses).
legal_relation_instance(clausula_quinta_preco, no_right_to_action, art_stars_software_ltda, receive_compensation_for_unused_object).
legal_relation_instance(clausula_quinta_preco, subjection, art_stars_software_ltda, be_subject_to_reduced_payments).
legal_relation_instance(clausula_quinta_preco, right_to_action, art_stars_software_ltda, receive_payment_for_licenses).
legal_relation_instance(clausula_sexta_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_party).
legal_relation_instance(clausula_sexta_pagamento, right_to_action, art_stars_software_ltda, receive_payment).
legal_relation_instance(clausula_sexta_pagamento, duty_to_act, art_stars_software_ltda, send_fiscal_document).
legal_relation_instance(clausula_sexta_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_fiscal_document).
legal_relation_instance(clausula_sexta_pagamento, duty_to_act, art_stars_software_ltda, provide_regularity_certificates).
legal_relation_instance(clausula_sexta_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_regularity_certificates).
legal_relation_instance(clausula_sexta_pagamento, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_values).
legal_relation_instance(clausula_sexta_pagamento, subjection, art_stars_software_ltda, be_subject_to_deductions).
legal_relation_instance(clausula_sexta_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_interest).
legal_relation_instance(clausula_sexta_pagamento, right_to_action, art_stars_software_ltda, receive_interest).
legal_relation_instance(clausula_setima_equilibrio_economico_financeiro_contrato, right_to_action, art_stars_software_ltda, request_price_revision).
legal_relation_instance(clausula_setima_equilibrio_economico_financeiro_contrato, duty_to_act, art_stars_software_ltda, provide_evidence_for_revision).
legal_relation_instance(clausula_setima_equilibrio_economico_financeiro_contrato, no_right_to_action, art_stars_software_ltda, request_price_revision_after_deadline).
legal_relation_instance(clausula_setima_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_revision_request).
legal_relation_instance(clausula_setima_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, initiate_price_revision).
legal_relation_instance(clausula_setima_equilibrio_economico_financeiro_contrato, right_to_omission, art_stars_software_ltda, not_request_price_revision).
legal_relation_instance(clausula_oitava_matriz_riscos, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, identify_risks).
legal_relation_instance(clausula_oitava_matriz_riscos, duty_to_act, art_stars_software_ltda, identify_risks).
legal_relation_instance(clausula_oitava_matriz_riscos, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, establish_responsibilities).
legal_relation_instance(clausula_oitava_matriz_riscos, duty_to_act, art_stars_software_ltda, establish_responsibilities).
legal_relation_instance(clausula_nona_obrigacoes_contratado, duty_to_act, art_stars_software_ltda, maintain_qualification_conditions).
legal_relation_instance(clausula_nona_obrigacoes_contratado, duty_to_act, art_stars_software_ltda, communicate_penalties).
legal_relation_instance(clausula_nona_obrigacoes_contratado, duty_to_act, art_stars_software_ltda, repair_defects).
legal_relation_instance(clausula_nona_obrigacoes_contratado, duty_to_act, art_stars_software_ltda, repair_damages).
legal_relation_instance(clausula_nona_obrigacoes_contratado, duty_to_act, art_stars_software_ltda, pay_taxes).
legal_relation_instance(clausula_nona_obrigacoes_contratado, duty_to_act, art_stars_software_ltda, provide_exclusion_evidence).
legal_relation_instance(clausula_nona_obrigacoes_contratado, duty_to_act, art_stars_software_ltda, allow_inspections).
legal_relation_instance(clausula_nona_obrigacoes_contratado, duty_to_act, art_stars_software_ltda, obey_instructions).
legal_relation_instance(clausula_nona_obrigacoes_contratado, duty_to_act, art_stars_software_ltda, designate_representative).
legal_relation_instance(clausula_nona_obrigacoes_contratado, duty_to_act, art_stars_software_ltda, allow_central_bank_access).
legal_relation_instance(clausula_decima_conduta_etica_contratado_bndes, duty_to_act, art_stars_software_ltda, maintain_integrity_in_public_private_relations).
legal_relation_instance(clausula_decima_conduta_etica_contratado_bndes, duty_to_act, art_stars_software_ltda, act_in_good_faith).
legal_relation_instance(clausula_decima_conduta_etica_contratado_bndes, duty_to_omit, art_stars_software_ltda, not_offer_undue_advantage).
legal_relation_instance(clausula_decima_conduta_etica_contratado_bndes, duty_to_omit, art_stars_software_ltda, prevent_favoritism_of_bndes_employees).
legal_relation_instance(clausula_decima_conduta_etica_contratado_bndes, duty_to_omit, art_stars_software_ltda, prevent_allocation_of_bndes_employee_family_members).
legal_relation_instance(clausula_decima_conduta_etica_contratado_bndes, duty_to_act, art_stars_software_ltda, observe_bndes_code_of_ethics).
legal_relation_instance(clausula_decima_conduta_etica_contratado_bndes, duty_to_act, art_stars_software_ltda, adopt_good_environmental_practices).
legal_relation_instance(clausula_decima_conduta_etica_contratado_bndes, duty_to_act, art_stars_software_ltda, remove_agents_implying_impediments).
legal_relation_instance(clausula_decima_conduta_etica_contratado_bndes, duty_to_act, art_stars_software_ltda, report_situations_to_bndes).
legal_relation_instance(clausula_decima_conduta_etica_contratado_bndes, duty_to_act, art_stars_software_ltda, prevent_undue_advantage_by_others).
legal_relation_instance(clausula_decima_primeira_sigilo_informacoes, duty_to_act, art_stars_software_ltda, maintain_confidentiality).
legal_relation_instance(clausula_decima_primeira_sigilo_informacoes, duty_to_act, art_stars_software_ltda, provide_confidentiality_agreement).
legal_relation_instance(clausula_decima_primeira_sigilo_informacoes, duty_to_omit, art_stars_software_ltda, omit_disclosure_confidential_info).
legal_relation_instance(clausula_decima_primeira_sigilo_informacoes, duty_to_act, art_stars_software_ltda, orient_professionals).
legal_relation_instance(clausula_decima_primeira_sigilo_informacoes, duty_to_act, art_stars_software_ltda, sign_confidentiality_agreement).
legal_relation_instance(clausula_decima_primeira_sigilo_informacoes, right_to_omission, unknown, refrain_from_disclosing_info).
legal_relation_instance(clausula_decima_segunda_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contracted_party).
legal_relation_instance(clausula_decima_segunda_obrigacoes_bndes, right_to_action, art_stars_software_ltda, receive_payments_from_bndes).
legal_relation_instance(clausula_decima_segunda_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager).
legal_relation_instance(clausula_decima_segunda_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_information_to_contracted_party).
legal_relation_instance(clausula_decima_segunda_obrigacoes_bndes, right_to_action, art_stars_software_ltda, receive_information_from_bndes).
legal_relation_instance(clausula_decima_segunda_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_necessary_information).
legal_relation_instance(clausula_decima_segunda_obrigacoes_bndes, right_to_action, art_stars_software_ltda, receive_necessary_information).
legal_relation_instance(clausula_decima_segunda_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions_procedures).
legal_relation_instance(clausula_decima_segunda_obrigacoes_bndes, right_to_action, art_stars_software_ltda, receive_instructions_procedures).
legal_relation_instance(clausula_decima_segunda_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_investigation_opening).
legal_relation_instance(clausula_decima_terceira_cessao_contrato_credito_sucessao_subcontratacao, duty_to_omit, art_stars_software_ltda, omit_contract_assignment).
legal_relation_instance(clausula_decima_terceira_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, art_stars_software_ltda, assign_contract).
legal_relation_instance(clausula_decima_terceira_cessao_contrato_credito_sucessao_subcontratacao, duty_to_omit, art_stars_software_ltda, omit_issue_credit_title).
legal_relation_instance(clausula_decima_terceira_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, art_stars_software_ltda, issue_credit_title).
legal_relation_instance(clausula_decima_terceira_cessao_contrato_credito_sucessao_subcontratacao, duty_to_omit, art_stars_software_ltda, omit_subcontract).
legal_relation_instance(clausula_decima_terceira_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, art_stars_software_ltda, subcontract_work).
legal_relation_instance(clausula_decima_terceira_cessao_contrato_credito_sucessao_subcontratacao, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_risks_succession).
legal_relation_instance(clausula_decima_quarta_penalidades, subjection, art_stars_software_ltda, be_subject_to_penalty).
legal_relation_instance(clausula_decima_quarta_penalidades, right_to_action, art_stars_software_ltda, defend_oneself).
legal_relation_instance(clausula_decima_quarta_penalidades, right_to_action, art_stars_software_ltda, appeal_penalty).
legal_relation_instance(clausula_decima_quarta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_from_credits).
legal_relation_instance(clausula_decima_quarta_penalidades, duty_to_act, art_stars_software_ltda, perform_contract).
legal_relation_instance(clausula_decima_quarta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalty).
legal_relation_instance(clausula_decima_quarta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_quinta_alterações_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alterar_contrato).
legal_relation_instance(clausula_decima_quinta_alterações_contratuais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, nao_desnaturar_objeto_contratacao).
legal_relation_instance(clausula_decima_quinta_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalizar_alteracao_contratual).
legal_relation_instance(clausula_decima_quinta_alterações_contratuais, right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, recusar_alteracao_com_justo_motivo).
legal_relation_instance(clausula_decima_quinta_alterações_contratuais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, cobrar_por_danos).
legal_relation_instance(clausula_decima_quinta_alterações_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, responder_por_danos).
legal_relation_instance(clausula_decima_sexta_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_other_party).
legal_relation_instance(clausula_decima_sexta_extinção_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, right_to_defend).
legal_relation_instance(clausula_decima_sexta_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_opportunity_to_defend).
legal_relation_instance(clausula_decima_sexta_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_breaching_party).
legal_relation_instance(clausula_decima_sexta_extinção_contrato, power, unknown, extinguish_contract).
legal_relation_instance(clausula_decima_sexta_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, resolve_contract).
legal_relation_instance(clausula_decima_setima_disposições_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights).
legal_relation_instance(clausula_decima_setima_disposições_finais, no_right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_enforcement).
legal_relation_instance(clausula_decima_setima_disposições_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, claim_novation).
legal_relation_instance(clausula_decima_setima_disposições_finais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, comply_with_obligations).
legal_relation_instance(clausula_decima_oitava_foro, power, unknown, decide_litigation_venue).
legal_relation_instance(clausula_decima_oitava_foro, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, be_subject_to_rio_de_janeiro_court).
legal_relation_instance(clausula_decima_oitava_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, litigate_outside_rio).

% --- Action catalog (local to this contract grounding) ---
action_type(acquire_licenses).
action_label(acquire_licenses, 'Acquire licenses').
action_type(act_in_good_faith).
action_label(act_in_good_faith, 'Act in good faith').
action_type(adopt_good_environmental_practices).
action_label(adopt_good_environmental_practices, 'Adopt good environmental practices').
action_type(allow_central_bank_access).
action_label(allow_central_bank_access, 'Allow central bank access').
action_type(allow_inspections).
action_label(allow_inspections, 'Allow inspections').
action_type(alter_contract_manager).
action_label(alter_contract_manager, 'Alter contract manager').
action_type(alterar_contrato).
action_label(alterar_contrato, 'Alter contract').
action_type(analyze_revision_request).
action_label(analyze_revision_request, 'Analyze revision request').
action_type(analyze_risks_succession).
action_label(analyze_risks_succession, 'Analyze succession risks').
action_type(appeal_penalty).
action_label(appeal_penalty, 'Right to appeal').
action_type(apply_penalty).
action_label(apply_penalty, 'Apply penalty').
action_type(assign_contract).
action_label(assign_contract, 'No right to assign contract').
action_type(be_informed_investigation_opening).
action_label(be_informed_investigation_opening, 'Be informed of investigation opening').
action_type(be_informed_penalty).
action_label(be_informed_penalty, 'Be informed of penalty').
action_type(be_subject_to_deductions).
action_label(be_subject_to_deductions, 'Be subject to deductions').
action_type(be_subject_to_penalty).
action_label(be_subject_to_penalty, 'Subject to penalty').
action_type(be_subject_to_reduced_payments).
action_label(be_subject_to_reduced_payments, 'Subject to reduced payments').
action_type(be_subject_to_rio_de_janeiro_court).
action_label(be_subject_to_rio_de_janeiro_court, 'Subject to Rio de Janeiro court').
action_type(bear_cost_of_quantity_mismatch).
action_label(bear_cost_of_quantity_mismatch, 'Bear cost of quantity mismatch').
action_type(claim_novation).
action_label(claim_novation, 'Claim novation').
action_type(cobrar_por_danos).
action_label(cobrar_por_danos, 'Claim for damages').
action_type(communicate_instructions_procedures).
action_label(communicate_instructions_procedures, 'Communicate instructions/procedures').
action_type(communicate_investigation_opening).
action_label(communicate_investigation_opening, 'Communicate investigation opening').
action_type(communicate_penalties).
action_label(communicate_penalties, 'Communicate penalties').
action_type(communicate_penalty).
action_label(communicate_penalty, 'Communicate penalty').
action_type(comply_with_obligations).
action_label(comply_with_obligations, 'Comply with obligations').
action_type(decide_litigation_venue).
action_label(decide_litigation_venue, 'Decide litigation venue').
action_type(deduct_from_credits).
action_label(deduct_from_credits, 'Deduct from credits').
action_type(deduct_values).
action_label(deduct_values, 'Deduct values').
action_type(defend_oneself).
action_label(defend_oneself, 'Right to defend').
action_type(define_contract_scope).
action_label(define_contract_scope, 'Define contract scope').
action_type(demand_proof_of_tax_regularity).
action_label(demand_proof_of_tax_regularity, 'Demand proof of tax regularity').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(effectuate_object_receipt).
action_label(effectuate_object_receipt, 'Effectuate receipt of object').
action_type(enforce_contract_for_60_days).
action_label(enforce_contract_for_60_days, 'Enforce contract for 60 days').
action_type(ensure_security_compliance).
action_label(ensure_security_compliance, 'Ensure security compliance').
action_type(establish_responsibilities).
action_label(establish_responsibilities, 'Establish responsibilities').
action_type(execute_contract_object).
action_label(execute_contract_object, 'Execute contract object per specifications').
action_type(exercise_rights).
action_label(exercise_rights, 'Exercise rights').
action_type(expect_execution_per_specs).
action_label(expect_execution_per_specs, 'Expect execution per specifications').
action_type(extinguish_contract).
action_label(extinguish_contract, 'Power to extinguish contract').
action_type(formalizar_alteracao_contratual).
action_label(formalizar_alteracao_contratual, 'Formalize contract alteration').
action_type(fulfill_contract_for_60_days).
action_label(fulfill_contract_for_60_days, 'Fulfill contract for 60 days').
action_type(guarantee_no_copyright_infringement).
action_label(guarantee_no_copyright_infringement, 'Guarantee no copyright infringement').
action_type(identify_risks).
action_label(identify_risks, 'Identify risks').
action_type(initiate_price_revision).
action_label(initiate_price_revision, 'Initiate price revision').
action_type(issue_credit_title).
action_label(issue_credit_title, 'No right to issue credit title').
action_type(litigate_outside_rio).
action_label(litigate_outside_rio, 'Litigate outside Rio').
action_type(maintain_confidentiality).
action_label(maintain_confidentiality, 'Maintain confidentiality').
action_type(maintain_integrity_in_public_private_relations).
action_label(maintain_integrity_in_public_private_relations, 'Maintain integrity').
action_type(maintain_qualification_conditions).
action_label(maintain_qualification_conditions, 'Maintain qualification conditions').
action_type(make_payments_to_contracted_party).
action_label(make_payments_to_contracted_party, 'Make payments to contracted party').
action_type(nao_desnaturar_objeto_contratacao).
action_label(nao_desnaturar_objeto_contratacao, 'Do not denature contract object').
action_type(not_offer_undue_advantage).
action_label(not_offer_undue_advantage, 'Not offer undue advantage').
action_type(not_request_price_revision).
action_label(not_request_price_revision, 'Not request price revision').
action_type(notify_breaching_party).
action_label(notify_breaching_party, 'Duty to notify breaching party').
action_type(notify_other_party).
action_label(notify_other_party, 'Duty to notify other party').
action_type(obey_instructions).
action_label(obey_instructions, 'Obey instructions').
action_type(observe_bndes_code_of_ethics).
action_label(observe_bndes_code_of_ethics, 'Observe BNDES code of ethics').
action_type(omit_contract_assignment).
action_label(omit_contract_assignment, 'Omit contract assignment').
action_type(omit_disclosure_confidential_info).
action_label(omit_disclosure_confidential_info, 'Omit disclosure of info').
action_type(omit_enforcement).
action_label(omit_enforcement, 'Omit enforcement').
action_type(omit_issue_credit_title).
action_label(omit_issue_credit_title, 'Omit issuing credit title').
action_type(omit_subcontract).
action_label(omit_subcontract, 'Omit subcontracting').
action_type(orient_professionals).
action_label(orient_professionals, 'Orient professionals').
action_type(pay_contracted_party).
action_label(pay_contracted_party, 'Pay contracted party').
action_type(pay_for_licenses).
action_label(pay_for_licenses, 'Pay for licenses').
action_type(pay_interest).
action_label(pay_interest, 'Pay interest').
action_type(pay_taxes).
action_label(pay_taxes, 'Pay taxes').
action_type(perform_contract).
action_label(perform_contract, 'Perform contract').
action_type(present_dif).
action_label(present_dif, 'Present DIF').
action_type(prevent_allocation_of_bndes_employee_family_members).
action_label(prevent_allocation_of_bndes_employee_family_members, 'Prevent family allocation').
action_type(prevent_favoritism_of_bndes_employees).
action_label(prevent_favoritism_of_bndes_employees, 'Prevent favoritism').
action_type(prevent_undue_advantage_by_others).
action_label(prevent_undue_advantage_by_others, 'Prevent undue advantage by others').
action_type(provide_confidentiality_agreement).
action_label(provide_confidentiality_agreement, 'Provide confidentiality agreement').
action_type(provide_evidence_for_revision).
action_label(provide_evidence_for_revision, 'Provide evidence for revision').
action_type(provide_exclusion_evidence).
action_label(provide_exclusion_evidence, 'Provide exclusion evidence').
action_type(provide_information_to_contracted_party).
action_label(provide_information_to_contracted_party, 'Provide information to contracted party').
action_type(provide_necessary_information).
action_label(provide_necessary_information, 'Provide necessary information').
action_type(provide_opportunity_to_defend).
action_label(provide_opportunity_to_defend, 'Duty to provide defense opportunity').
action_type(provide_regularity_certificates).
action_label(provide_regularity_certificates, 'Provide regularity certificates').
action_type(receive_compensation_for_unused_object).
action_label(receive_compensation_for_unused_object, 'No compensation for unused object').
action_type(receive_fiscal_document).
action_label(receive_fiscal_document, 'Receive fiscal document').
action_type(receive_information_from_bndes).
action_label(receive_information_from_bndes, 'Receive information from BNDES').
action_type(receive_instructions_procedures).
action_label(receive_instructions_procedures, 'Receive instructions/procedures').
action_type(receive_interest).
action_label(receive_interest, 'Receive interest').
action_type(receive_necessary_information).
action_label(receive_necessary_information, 'Receive necessary information').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payment_for_licenses).
action_label(receive_payment_for_licenses, 'Receive payment for licenses').
action_type(receive_payments_from_bndes).
action_label(receive_payments_from_bndes, 'Receive payments from BNDES').
action_type(receive_regularity_certificates).
action_label(receive_regularity_certificates, 'Receive regularity certificates').
action_type(recusar_alteracao_com_justo_motivo).
action_label(recusar_alteracao_com_justo_motivo, 'Refuse alteration with just cause').
action_type(refrain_from_disclosing_info).
action_label(refrain_from_disclosing_info, 'Refrain from disclosing info').
action_type(remove_agents_implying_impediments).
action_label(remove_agents_implying_impediments, 'Remove agents with impediments').
action_type(repair_damages).
action_label(repair_damages, 'Repair damages').
action_type(repair_defects).
action_label(repair_defects, 'Repair defects').
action_type(report_irregularities).
action_label(report_irregularities, 'Report irregularities').
action_type(report_situations_to_bndes).
action_label(report_situations_to_bndes, 'Report situations to BNDES').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_price_revision_after_deadline).
action_label(request_price_revision_after_deadline, 'No right to request after deadline').
action_type(resolve_contract).
action_label(resolve_contract, 'Power to resolve contract').
action_type(responder_por_danos).
action_label(responder_por_danos, 'Be liable for damages').
action_type(right_to_defend).
action_label(right_to_defend, 'Right to defend').
action_type(send_fiscal_document).
action_label(send_fiscal_document, 'Send fiscal document').
action_type(sign_confidentiality_agreement).
action_label(sign_confidentiality_agreement, 'Sign confidentiality agreement').
action_type(subcontract_work).
action_label(subcontract_work, 'No right to subcontract').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_120_2020).
contract_metadata(contrato_ocs_120_2020, numero_ocs, '120/2020').
contract_metadata(contrato_ocs_120_2020, numero_sap, '4400004258').
contract_metadata(contrato_ocs_120_2020, tipo_contrato, 'CONTRATO DE AQUISIÇÃO DE LICENÇA DE USO DE SOFTWARE').
contract_metadata(contrato_ocs_120_2020, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'ART STARS SOFTWARE LTDA']).
contract_metadata(contrato_ocs_120_2020, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_120_2020, contratado, 'ART STARS SOFTWARE LTDA').
contract_metadata(contrato_ocs_120_2020, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_120_2020, cnpj_contratado, '07.280.069/0001-65').
contract_metadata(contrato_ocs_120_2020, procedimento_licitatorio, 'Pregão Eletrônico nº 10/2020 - BNDES').
contract_metadata(contrato_ocs_120_2020, data_autorizacao, '02/03/2020').
contract_metadata_raw(contrato_ocs_120_2020, 'IP ATI/DESET', '03/2020', 'trecho_literal').
contract_metadata(contrato_ocs_120_2020, data_ip_ati_degat, '12/02/2020').
contract_metadata(contrato_ocs_120_2020, rubrica_orcamentaria, '1800100011').
contract_metadata(contrato_ocs_120_2020, centro_custo, 'BN30005000').
contract_metadata(contrato_ocs_120_2020, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata_raw(contrato_ocs_120_2020, 'Regulamento', 'Regulamento de Formalização, Execução e Fiscalização de Contratos Administrativos do Sistema BNDES', 'trecho_literal').
contract_clause(contrato_ocs_120_2020, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a aquisição de 350 (trezentos e cinquenta) licenças de uso do tipo Windows Server 2019 RDS CAL (Remote Desktop Services Client Access License), na modalidade Per User (por usuário), conforme especificações constantes do Termo de Referência (Anexo I do Edital do Pregão Eletrônico nº 10/2020 - BNDES) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_120_2020, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 60 (sessenta) dias, a contar da data de sua assinatura.').
contract_clause(contrato_ocs_120_2020, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Termo de Referência (Anexo I deste Contrato) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_120_2020, clausula_quarta_recebimento_objeto, 'CLÁUSULA QUARTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor mencionado na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_120_2020, clausula_quinta_preco, 'CLÁUSULA QUINTA – PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de R$ 245,71 (duzentos e quarenta e cinco reais e setenta e um centavos) por licença, perfazendo o valor global de R$ 85.998,50 (oitenta e cinco mil, novecentos e noventa e oito reais e cinquenta centavos), conforme proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento.  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização ao CONTRATADO.   Parágrafo Quarto O CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua proposta, devendo, conforme o caso: I. complementá-los, caso os quantitativos previstos inicialmente em sua proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato; ou II. reverter o excedente como lucro, sendo facultada ao BNDES a promoção de negociação com vistas a eventual prorrogação contratual.').
contract_clause(contrato_ocs_120_2020, clausula_sexta_pagamento, 'CLÁUSULA SEXTA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, em parcela única, por meio de crédito em conta bancária, em até 10 (dez) dias úteis a contar da data de apresentação do documento fiscal ou equivalente legal (como nota fiscal, fatura, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Termo de Referência (Anexo I deste Contrato).    Parágrafo Primeiro  Para toda efetivação de pagamento, ao CONTRATADO deverá encaminhar 1 (uma) via do documento fiscal ou equivalente legal à caixa de e-mail nfe@bndes.gov.br, ou, quando emitido em papel, ao Protocolo do Edifício de Serviços do BNDES no Rio de Janeiro – EDSERJ, localizado na Avenida República do Chile nº 100, Térreo, Centro, Rio de Janeiro, CEP 20031-917, no período compreendido entre 10h e 18h.  Parágrafo Segundo O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. descrição detalhada do objeto executado e dos respectivos valores; IV. período de referência da execução do objeto; V. nome e número do CNPJ do CONTRATADO, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VI. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; VII. nome e número do banco e da agência, bem como o número da conta corrente da CONTRATADA, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; VIII. contratante: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; IX. CNPJ do contratante: 33.657.248/0001-89; X. local de execução do objeto, discriminando-se os valores por localidade, se for o caso;  XI. Se for o caso, código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento.  Parágrafo Terceiro Ao documento fiscal ou equivalente legal, deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que a CONTRATADA é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; e IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado.  Parágrafo Quarto Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal à CONTRATADA ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que esta providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.    Parágrafo Quinto Os pagamentos a serem efetuados em favor da CONTRATADA estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pela CONTRATADA.  Parágrafo Sexto Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pela CONTRATADA.  Parágrafo Sétimo Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível à CONTRATADA, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.').
contract_clause(contrato_ocs_120_2020, clausula_setima_equilibrio_economico_financeiro_contrato, 'CLÁUSULA SÉTIMA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO', 'Considerando o prazo de vigência do presente Contrato, não se admite reajuste ou repactuação de preços, devendo o CONTRATADO arcar com eventuais elevações dos custos decorrentes de fatores ordinários, tais como alterações de acordo ou convenção coletiva de trabalho.  Parágrafo Primeiro O BNDES e o CONTRATADO têm direito à revisão de preços, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, desde que ocorra fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. a revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO. Neste último caso, o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta e do momento do pedido da revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta e o momento do pedido de revisão,  contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Segundo O CONTRATADO deverá solicitar a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador da revisão de preços ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador, para solicitar a revisão de preços; II. o BNDES deverá analisar o pedido de revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e III. caso o CONTRATADO não solicite a revisão de preços nos prazos fixados acima, não fará jus à mesma, operando-se a renúncia ao seu eventual direito.').
contract_clause(contrato_ocs_120_2020, clausula_oitava_matriz_riscos, 'CLÁUSULA OITAVA – MATRIZ DE RISCOS', 'O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.').
contract_clause(contrato_ocs_120_2020, clausula_nona_obrigacoes_contratado, 'CLÁUSULA NONA  – OBRIGAÇÕES DO CONTRATADO', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição, a si ou a seus administradores, de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato;  V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; VIII. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; IX. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; X. permitir ao Banco Central do Brasil acesso a termos firmados, documentos e informações atinentes aos serviços prestados, bem como às suas dependências, nos termos do § 1° do artigo 33 da Resolução CMN n° 4.557/2017; XI. apresentar, em até 10 dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; XII. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo o CONTRATADO ser instado a intervir no processo; e  XIII.  responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução do objeto, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES.').
contract_clause(contrato_ocs_120_2020, clausula_decima_conduta_etica_contratado_bndes, 'CLÁUSULA DÉCIMA – CONDUTA ÉTICA DO CONTRATADO E DO BNDES', 'O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.   Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar o Código de Ética do Sistema BNDES vigente ao tempo da contratação, bem como a Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção. Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão  ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_120_2020, clausula_decima_primeira_sigilo_informacoes, 'CLÁUSULA DÉCIMA PRIMEIRA – SIGILO DAS INFORMAÇÕES', 'Caso o CONTRATADO venha a ter acesso a dados, materiais, documentos e informações de natureza sigilosa, direta ou indiretamente, em decorrência da execução do objeto contratual, deverá manter o sigilo dos mesmos, bem como orientar os profissionais envolvidos a cumprir esta obrigação, respeitando-se as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES.  Parágrafo Único Assim que solicitado pelo Gestor do Contrato, o CONTRATADO deverá providenciar a assinatura, por seu representante legal e pelos profissionais que tiverem acesso a informações sigilosas, dos Termos de Confidencialidade a serem disponibilizados pelo BNDES.').
contract_clause(contrato_ocs_120_2020, clausula_decima_segunda_obrigacoes_bndes, 'CLÁUSULA DÉCIMA SEGUNDA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Eduardo Carneiro da Cunha, que atualmente exerce a função de Coordenador de Serviços do ATI/DESET/GEAT, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita ao CONTRATADO; IV. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; V. colocar à disposição do CONTRATADO todas as informações necessárias à perfeita execução dos serviços objeto deste Contrato; e VI. comunicar ao CONTRATADO, por escrito:   a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_120_2020, clausula_decima_terceira_cessao_contrato_credito_sucessao_subcontratacao, 'CLÁUSULA DÉCIMA TERCEIRA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', 'É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.').
contract_clause(contrato_ocs_120_2020, clausula_decima_quarta_penalidades, 'CLÁUSULA DÉCIMA QUARTA – PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: I. advertência; II. multa: a) de até 0,5% (cinco décimos por cento), aplicada sobre o valor referente às licenças de software do Contrato, por cada dia corrido de atraso no prazo de entrega, definido no item 3.2 do Anexo I – Termo de Referência, limitado a 10% (dez por cento) do valor global do Contrato;  b) de até 10% (dez por cento), apurada de acordo com a gravidade da infração, incidente sobre o valor global do Contrato, em razão do descumprimento de outras obrigações contratuais não previstas no item anterior; III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades indicadas nesta Cláusula somente poderão ser aplicadas após procedimento administrativo, e desde que assegurados o contraditório e a ampla defesa, facultada ao CONTRATADO a defesa prévia, no prazo de 10 (dez) dias úteis.  Parágrafo Segundo  Contra a decisão de aplicação de penalidade, o CONTRATADO poderá interpor o recurso cabível, na forma e no prazo previstos no Regulamento de Formalização, Execução e Fiscalização de Contratos Administrativos do Sistema BNDES.  Parágrafo Terceiro  A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto  A multa prevista nesta Cláusula poderá ser aplicada juntamente com as demais penalidades.  Parágrafo Quinto  A multa aplicada ao CONTRATADO e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto  No caso de uso indevido de informações sigilosas, observar-se-ão, no que couber, os termos da Lei nº 12.527/2011 e do Decreto nº 7.724/2012.  Parágrafo Sétimo  No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Oitavo A sanção prevista no inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no  recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_120_2020, clausula_decima_quinta_alterações_contratuais, 'CLÁUSULA DÉCIMA QUINTA – ALTERAÇÕES CONTRATUAIS', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo       A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.     Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento e os pequenos ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato, que poderão ser celebrados por meio epistolar.').
contract_clause(contrato_ocs_120_2020, clausula_decima_sexta_extinção_contrato, 'CLÁUSULA DÉCIMA SEXTA – EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, convencionando-se, ainda, que é cabível a sua resolução: I. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; III. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por  prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo;  IV. quando for decretada a falência do CONTRATADO; V. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VI. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  VIII. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; IX. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; X. em razão da dissolução do CONTRATADO; e  XI. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_120_2020, clausula_decima_setima_disposições_finais, 'CLÁUSULA DÉCIMA SÉTIMA – DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram o presente Contrato: Anexo I - Termo de Referência do Pregão Eletrônico nº 10/2020 - BNDES Anexo II - Proposta Anexo III - Matriz de Risco  Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá  renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_120_2020, clausula_decima_oitava_foro, 'CLÁUSULA DÉCIMA OITAVA – FORO', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As folhas deste Contrato foram conferidas por Cesar Santos Rodrigues, advogado do BNDES, por autorização do(s) representante(s) legal(is) que o assina(m).  E, por estarem assim justos e contratados, firmam o presente Instrumento, redigido em 1 (uma)  via, juntamente com as testemunhas abaixo.  Reputa-se celebrado o presente Contrato na data em que for registrada a assinatura dos representantes legais do BNDES.       __________________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES     __________________________________________________________________________ ART STARS SOFTWARE LTDA   Testemunhas:    _________________________________ _________________________________ Nome/CPF: Nome/CPF:    ART STARS SOFTWARE LTDA:07280069000165Assinado de forma digital por ART STARS SOFTWARE LTDA:07280069000165 Dados: 2020.06.01 16:39:55 -03\'00\'FERNANDO PASSERI LAVRADO:00486757765Assinado de forma digital por FERNANDO PASSERI LAVRADO:00486757765 Dados: 2020.06.08 10:45:45 -03\'00\'HERILMAR POMPERMAYER FREIRE:00181257785Assinado de forma digital por HERILMAR POMPERMAYER FREIRE:00181257785 Dados: 2020.06.08 12:13:57 -03\'00\'ANA PAULA SOEIRO DE BRITTO:09667275760Assinado de forma digital por ANA PAULA SOEIRO DE BRITTO:09667275760 Dados: 2020.06.08 14:22:37 -03\'00\'JULIA BOHRER RODRIGUES:11277197776Assinado de forma digital por JULIA BOHRER RODRIGUES:11277197776 Dados: 2020.06.09 16:57:30 -03\'00\'').

% ===== END =====
